export default function SMSFallback() {
  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 20 }}>
        {/* Header */}
        <div style={{ padding: '20px 20px 0', textAlign: 'center' }}>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: '#0F172A' }}>Works for Everyone</h1>
          <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>ಎಲ್ಲರಿಗೂ ಕೆಲಸ ಮಾಡುತ್ತದೆ</p>
        </div>

        {/* 3-Tier Pyramid */}
        <div style={{ padding: '20px 20px 0', display: 'flex', flexDirection: 'column', gap: 0, alignItems: 'center' }}>
          {/* Tier 1 - Full App (top, narrowest) */}
          <div style={{
            width: '70%', background: 'linear-gradient(135deg, #22C55E, #16A34A)',
            borderRadius: '16px 16px 0 0', padding: '16px', textAlign: 'center',
            position: 'relative', zIndex: 3,
          }}>
            <span style={{ fontSize: 24 }}>📱</span>
            <div style={{ fontSize: 14, fontWeight: 700, color: 'white', marginTop: 4 }}>Full App Users</div>
            <div style={{ fontSize: 11, color: 'rgba(255,255,255,0.8)' }}>Smartphone + Internet</div>
            <div style={{ fontSize: 10, color: 'rgba(255,255,255,0.6)', marginTop: 2 }}>Flutter App — Full Features</div>
          </div>

          {/* Tier 2 - WhatsApp (middle, wider) */}
          <div style={{
            width: '85%', background: 'linear-gradient(135deg, #25D366, #128C7E)',
            padding: '16px', textAlign: 'center',
            position: 'relative', zIndex: 2, marginTop: -4,
          }}>
            <span style={{ fontSize: 24 }}>💬</span>
            <div style={{ fontSize: 14, fontWeight: 700, color: 'white', marginTop: 4 }}>WhatsApp Users</div>
            <div style={{ fontSize: 11, color: 'rgba(255,255,255,0.8)' }}>Basic smartphone</div>
            <div style={{ fontSize: 10, color: 'rgba(255,255,255,0.6)', marginTop: 2 }}>Message 'JOBS' to get listings</div>
            {/* Mock WhatsApp chat */}
            <div style={{
              background: '#ECE5DD', borderRadius: 10, padding: '10px 12px',
              marginTop: 10, textAlign: 'left',
            }}>
              <div style={{
                background: '#DCF8C6', borderRadius: '8px 8px 8px 0',
                padding: '6px 10px', marginBottom: 6, display: 'inline-block',
                fontSize: 11, color: '#0F172A',
              }}>
                JOBS KODIALBAIL COOK
              </div>
              <div style={{
                background: 'white', borderRadius: '8px 8px 0 8px',
                padding: '8px 10px', fontSize: 11, color: '#0F172A', lineHeight: 1.5,
              }}>
                Found 3 cooking jobs near you:<br />
                1. Hotel Udupi — ₹500/day — 8 min<br />
                Reply 1, 2, or 3 to apply
              </div>
            </div>
          </div>

          {/* Tier 3 - SMS (bottom, widest) */}
          <div style={{
            width: '100%', background: 'linear-gradient(135deg, #3B82F6, #1D4ED8)',
            borderRadius: '0 0 16px 16px', padding: '16px', textAlign: 'center',
            position: 'relative', zIndex: 1, marginTop: -4,
          }}>
            <span style={{ fontSize: 24 }}>📨</span>
            <div style={{ fontSize: 14, fontWeight: 700, color: 'white', marginTop: 4 }}>Feature Phone Users</div>
            <div style={{ fontSize: 11, color: 'rgba(255,255,255,0.8)' }}>Any phone, any network</div>
            <div style={{ fontSize: 10, color: 'rgba(255,255,255,0.6)', marginTop: 2 }}>SMS 'WORK' to 56789</div>
            {/* Mock SMS */}
            <div style={{
              background: 'rgba(255,255,255,0.15)', borderRadius: 10, padding: '10px 12px',
              marginTop: 10, textAlign: 'left',
            }}>
              <div style={{ fontSize: 11, color: 'rgba(255,255,255,0.7)', marginBottom: 4 }}>
                <strong>Send:</strong> WORK KODIALBAIL
              </div>
              <div style={{ fontSize: 11, color: 'white', lineHeight: 1.5 }}>
                <strong>Receive:</strong> 3 jobs near you.<br />
                1.Shop Asst Rs500/day<br />
                Reply 1 to apply
              </div>
            </div>
          </div>
        </div>

        {/* Impact Statement */}
        <div style={{ padding: '20px 20px 0' }}>
          <div style={{
            background: '#F0FDF4', borderRadius: 12, padding: '14px 16px',
            border: '1px solid #22C55E', textAlign: 'center',
          }}>
            <p style={{ fontSize: 14, fontWeight: 600, color: '#22C55E', lineHeight: 1.5 }}>
              This means EmployMe reaches users that NO other job app can
            </p>
          </div>
        </div>

        {/* Phone Comparison */}
        <div style={{ padding: '20px 20px 0' }}>
          <div style={{ display: 'flex', gap: 12, alignItems: 'center' }}>
            {/* Budget phone */}
            <div style={{
              flex: 1, background: 'white', borderRadius: 16, padding: '16px',
              textAlign: 'center', boxShadow: '0 2px 8px rgba(0,0,0,0.06)',
            }}>
              <div style={{
                width: 50, height: 80, borderRadius: 8, background: '#E2E8F0',
                margin: '0 auto', display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <div style={{ width: 30, height: 40, borderRadius: 4, background: '#94A3B8' }} />
              </div>
              <p style={{ fontSize: 12, fontWeight: 700, color: '#0F172A', marginTop: 8 }}>₹500 Phone</p>
              <p style={{ fontSize: 11, color: '#22C55E', fontWeight: 600, marginTop: 4 }}>✅ Can use EmployMe via SMS</p>
            </div>

            {/* EmployMe logo center */}
            <div style={{
              width: 44, height: 44, borderRadius: 12, background: '#22C55E',
              display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
            }}>
              <span style={{ fontSize: 10, fontWeight: 800, color: 'white' }}>E</span>
            </div>

            {/* Smartphone */}
            <div style={{
              flex: 1, background: 'white', borderRadius: 16, padding: '16px',
              textAlign: 'center', boxShadow: '0 2px 8px rgba(0,0,0,0.06)',
            }}>
              <div style={{
                width: 50, height: 80, borderRadius: 12, background: '#0F172A',
                margin: '0 auto', display: 'flex', alignItems: 'center', justifyContent: 'center',
                border: '2px solid #374151',
              }}>
                <div style={{ width: 36, height: 60, borderRadius: 4, background: '#22C55E', opacity: 0.3 }} />
              </div>
              <p style={{ fontSize: 12, fontWeight: 700, color: '#0F172A', marginTop: 8 }}>Smartphone</p>
              <p style={{ fontSize: 11, color: '#22C55E', fontWeight: 600, marginTop: 4 }}>✅ Full EmployMe app</p>
            </div>
          </div>
        </div>

        {/* Bottom tagline */}
        <div style={{ padding: '24px 20px', textAlign: 'center' }}>
          <h2 style={{ fontSize: 18, fontWeight: 700, color: '#0F172A' }}>We don't leave anyone behind</h2>
          <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>ನಾವು ಯಾರನ್ನೂ ಹಿಂದೆ ಬಿಡುವುದಿಲ್ಲ</p>
        </div>
      </div>
    </div>
  )
}
