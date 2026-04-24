import { ArrowLeft } from 'lucide-react'

export default function NGOVerification() {
  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 100 }}>
        {/* Header */}
        <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <button style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 8, marginLeft: -8 }}>
              <ArrowLeft size={22} color="#0F172A" />
            </button>
            <div>
              <div style={{ fontSize: 20, fontWeight: 700, color: '#0F172A' }}>Get Verified</div>
              <div style={{ fontSize: 13, color: '#64748B' }}>ಪರಿಶೀಲನೆ ಪಡೆಯಿರಿ</div>
            </div>
          </div>
        </div>

        {/* Hero Banner */}
        <div style={{
          margin: '16px 20px', background: 'linear-gradient(135deg, #1E3A5F, #2D5986)',
          borderRadius: 16, padding: '20px',
        }}>
          <div style={{ fontSize: 28, marginBottom: 8 }}>🛡️</div>
          <div style={{ fontSize: 18, fontWeight: 700, color: 'white' }}>Become NGO Verified</div>
          <p style={{ fontSize: 14, color: 'rgba(255,255,255,0.8)', marginTop: 6, lineHeight: 1.5 }}>
            Workers with NGO verification get 3x more job offers
          </p>
          <p style={{ fontSize: 12, color: 'rgba(255,255,255,0.6)', marginTop: 4 }}>
            ಎನ್ಜಿಒ ಪರಿಶೀಲಿತ ಕಾರ್ಮಿಕರಿಗೆ 3x ಹೆಚ್ಚು ಅವಕಾಶ
          </p>
        </div>

        {/* Steps */}
        <div style={{ padding: '0 20px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 600, color: '#0F172A', marginBottom: 16 }}>
            3 Simple Steps / <span style={{ color: '#64748B', fontWeight: 400, fontSize: 14 }}>3 ಸರಳ ಹಂತಗಳು</span>
          </h3>

          {[
            { num: 1, icon: '📋', title: 'Submit your details', desc: 'We share your info securely with a trusted NGO near you' },
            { num: 2, icon: '📞', title: 'NGO contacts you', desc: 'An NGO volunteer calls you within 2 working days' },
            { num: 3, icon: '🏠', title: 'Quick in-person meet', desc: 'Brief 10-min meeting at a nearby community center' },
          ].map(step => (
            <div key={step.num} style={{
              display: 'flex', gap: 14, marginBottom: 16, alignItems: 'flex-start',
            }}>
              <div style={{
                width: 36, height: 36, borderRadius: '50%', background: '#3B82F6',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 16, fontWeight: 700, color: 'white', flexShrink: 0,
              }}>{step.num}</div>
              <div>
                <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>{step.icon} {step.title}</div>
                <div style={{ fontSize: 13, color: '#64748B', marginTop: 4, lineHeight: 1.5 }}>{step.desc}</div>
              </div>
            </div>
          ))}
        </div>

        {/* Trust Statement */}
        <div style={{
          margin: '0 20px 16px', background: '#F0FDF4', borderRadius: 12, padding: '14px 16px',
          border: '1px solid #22C55E',
        }}>
          <p style={{ fontSize: 14, fontWeight: 600, color: '#22C55E', textAlign: 'center' }}>
            100% Free • Takes 2-3 days
          </p>
          <p style={{ fontSize: 12, color: '#22C55E', textAlign: 'center', marginTop: 4 }}>
            Your Aadhaar is never stored by EmployMe
          </p>
        </div>

        {/* NGO Partners */}
        <div style={{ padding: '0 20px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 600, color: '#0F172A', marginBottom: 12 }}>
            Verified NGO Partners Near You
          </h3>

          {[
            { name: 'Kodialbail Community Trust', dist: '0.8 km', rating: '4.9', verified: 230 },
            { name: 'Mangalore Seva Samithi', dist: '1.2 km', rating: '4.7', verified: 180 },
          ].map(ngo => (
            <div key={ngo.name} style={{
              background: 'white', borderRadius: 16, padding: '16px', marginBottom: 10,
              boxShadow: '0 2px 8px rgba(0,0,0,0.06)',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <div style={{
                  width: 48, height: 48, borderRadius: '50%', background: '#EFF6FF',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: 20,
                }}>🏛️</div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>{ngo.name}</div>
                  <div style={{ display: 'flex', gap: 8, marginTop: 4, flexWrap: 'wrap' }}>
                    <span style={{ fontSize: 12, color: '#22C55E', fontWeight: 600 }}>📍 {ngo.dist} from you</span>
                    <span style={{ fontSize: 12, color: '#D97706' }}>⭐ {ngo.rating}</span>
                    <span style={{ fontSize: 12, color: '#64748B' }}>{ngo.verified} verified</span>
                  </div>
                </div>
              </div>
              <button style={{
                width: '100%', height: 40, borderRadius: 12, background: 'white',
                border: '1.5px solid #22C55E', color: '#22C55E', fontWeight: 600,
                fontSize: 13, cursor: 'pointer', marginTop: 12,
              }}>Select This NGO</button>
            </div>
          ))}
        </div>

        {/* Consent */}
        <div style={{ padding: '16px 20px', display: 'flex', alignItems: 'flex-start', gap: 10 }}>
          <div style={{
            width: 22, height: 22, borderRadius: 6, background: '#22C55E',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            flexShrink: 0, marginTop: 2,
          }}>
            <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
              <path d="M3 6L5 8L9 4" stroke="white" strokeWidth="2" strokeLinecap="round" />
            </svg>
          </div>
          <span style={{ fontSize: 14, color: '#0F172A', lineHeight: 1.5 }}>
            I agree to an in-person verification meeting with the selected NGO
          </span>
        </div>
      </div>

      {/* Bottom */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'white', padding: '12px 20px 28px',
        borderTop: '1px solid #E2E8F0',
      }}>
        <button style={{
          width: '100%', height: 56, borderRadius: 12, background: '#22C55E',
          color: 'white', fontWeight: 700, fontSize: 16, border: 'none',
          cursor: 'pointer', boxShadow: '0 4px 16px rgba(34,197,94,0.3)',
        }}>
          Request Verification / ಪರಿಶೀಲನೆ ಕೋರಿ
        </button>
      </div>
    </div>
  )
}
