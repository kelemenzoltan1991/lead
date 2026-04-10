// Supabase Edge Function: notify
// Env vars required:
// - RESEND_API_KEY
// - NOTIFY_FROM_EMAIL (e.g. "noreply@yourdomain.com")

Deno.serve(async (req) => {
  if (req.method !== 'POST') return new Response('Method Not Allowed', { status: 405 })

  try {
    const payload = await req.json()
    const eventType = payload?.event ?? 'new_lead'
    const advisors = Array.isArray(payload?.advisors) ? payload.advisors : []
    const lead = payload?.lead || {}

    const recipients = advisors
      .map((a: { email?: string }) => a?.email)
      .filter((e: string | undefined) => !!e)

    if (!recipients.length) {
      return Response.json({ ok: true, skipped: 'no advisor email' })
    }

    const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')
    const FROM = Deno.env.get('NOTIFY_FROM_EMAIL')
    if (!RESEND_API_KEY || !FROM) {
      return new Response('Missing RESEND_API_KEY or NOTIFY_FROM_EMAIL', { status: 500 })
    }

    const subject = eventType === 'test_email' ? 'Teszt email - Lead rendszer' : 'Új lead érkezett'
    const title = eventType === 'test_email' ? 'Teszt email érkezett' : 'Új lead érkezett'
    const html = `
      <h2>${title}</h2>
      <p><b>Ügyfél:</b> ${lead.customerName ?? ''}</p>
      <p><b>Telefon:</b> ${lead.phone ?? ''}</p>
      <p><b>Email:</b> ${lead.email ?? ''}</p>
      <p><b>Érdeklődés:</b> ${lead.interest ?? ''}</p>
      <p><b>Lead adó:</b> ${lead.leadGiverName ?? ''}</p>
      <p><b>Rögzítve:</b> ${lead.createdAt ?? ''}</p>
    `

    const resendRes = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: FROM,
        to: recipients,
        subject,
        html
      })
    })

    if (!resendRes.ok) {
      const txt = await resendRes.text()
      return new Response(`Resend error: ${txt}`, { status: 500 })
    }

    return Response.json({ ok: true, sentTo: recipients.length })
  } catch (e) {
    return new Response(`Error: ${e?.message ?? e}`, { status: 500 })
  }
})
