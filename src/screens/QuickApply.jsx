import { useState } from 'react'
import { ArrowLeft, Check } from 'lucide-react'

export default function QuickApply() {
  const [step, setStep] = useState(1)
  const [startTime, setStartTime] = useState('Today')

  if (step === 2) {
    return (
      <div className="mobile-frame-inner" style={{
        background: 'white', display: 'flex', flexDirection: 'column',
        alignItems: 'center', justifyContent: 'center', height: '100%', padding: 20,
      }}>
        {/* Success checkmark */}
        <div style={{
          width: 80, height: 80, borderRadius: '50%', background: '#F0FDF4',
          border: '3px solid #22C55E', display: 'flex', alignItems: 'center', justifyContent: 'center',
          marginBottom: 20,
        }}>
          <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
            <path d="M12 20L18 26L28 14" stroke="#22C55E" strokeWidth="4" strokeLinecap="round" strokeLinejoin="round"
              className="check-draw" style={{ strokeDasharray: 50 }} />
          </svg>
        </div>
        <h1 style={{ fontSize: 24, fontWeight: 700, color: '#22C55E' }}>Application Sent! 🎉</h1>
        <p style={{ fontSize: 14, color: '#64748B', marginTop: 6 }}>ಅರ್ಜಿ ಸಲ್ಲಿಸಲಾಗಿದೆ!</p>
        <p style={{
          fontSize: 15, color: '#64748B', textAlign: 'center',
          marginTop: 12, maxWidth: 280, lineHeight: 1.5,
        }}>
          Sri Ganesh Provision Store will contact you soon
        </p>
        <span style={{
          background: '#F0FDF4', color: '#22C55E', padding: '8px 16px',
          borderRadius: 20, fontSize: 13, fontWeight: 600, marginTop: 12,
        }}>Usually within 2 hours</span>

        <div style={{ display: 'flex', gap: 10, marginTop: 32, width: '100%', maxWidth: 300 }}>
          <button style={{
            flex: 1, height: 48, borderRadius: 12, background: 'white',
            border: '1.5px solid #E2E8F0', color: '#0F172A', fontWeight: 600,
            fontSize: 14, cursor: 'pointer',
          }}>View Application</button>
          <button onClick={() => setStep(1)} style={{
            flex: 1, height: 48, borderRadius: 12, background: '#22C55E',
            color: 'white', fontWeight: 700, fontSize: 14, border: 'none', cursor: 'pointer',
          }}>Find More Jobs</button>
        </div>
        <p style={{ fontSize: 13, color: '#22C55E', fontWeight: 600, marginTop: 20, cursor: 'pointer' }}>
          Share with a friend who needs work →
        </p>
      </div>
    )
  }

  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Header */}
      <div style={{ background: 'white', padding: '16px 20px', textAlign: 'center', borderBottom: '1px solid #E2E8F0' }}>
        <div style={{ display: 'flex', alignItems: 'center' }}>
          <button style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 8 }}>
            <ArrowLeft size={22} color="#0F172A" />
          </button>
          <div style={{ flex: 1 }}>
            <p style={{ fontSize: 14, color: '#64748B' }}>Applying for...</p>
            <p style={{ fontSize: 20, fontWeight: 700, color: '#0F172A' }}>Shop Assistant</p>
            <p style={{ fontSize: 14, color: '#22C55E', fontWeight: 600 }}>Sri Ganesh Provision Store</p>
          </div>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 12 }}>
          <span style={{ fontSize: 12, color: '#64748B' }}>Step 1 of 2</span>
          <div style={{ flex: 1, height: 3, borderRadius: 2, background: '#E2E8F0' }}>
            <div style={{ width: '50%', height: '100%', borderRadius: 2, background: '#22C55E' }} />
          </div>
        </div>
      </div>

      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 100 }}>
        <div style={{ padding: '20px' }}>
          <h2 style={{ fontSize: 20, fontWeight: 700, color: '#0F172A' }}>Confirm your details</h2>
          <p style={{ fontSize: 14, color: '#64748B', marginTop: 4 }}>We'll share these with the employer</p>

          {/* Profile Summary Card */}
          <div style={{
            border: '1.5px solid #22C55E', borderRadius: 16, padding: '16px',
            marginTop: 16, background: 'white', position: 'relative',
          }}>
            <span style={{
              position: 'absolute', top: 12, right: 12, fontSize: 13,
              color: '#22C55E', fontWeight: 600, cursor: 'pointer',
            }}>Edit</span>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <div style={{
                width: 52, height: 52, borderRadius: '50%', background: '#22C55E',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 20, fontWeight: 700, color: 'white',
              }}>R</div>
              <div>
                <div style={{ fontSize: 16, fontWeight: 700, color: '#0F172A' }}>Raju Kumar</div>
                <div style={{ display: 'flex', gap: 6, marginTop: 6, flexWrap: 'wrap' }}>
                  <span style={{ background: '#F0FDF4', color: '#22C55E', padding: '3px 10px', borderRadius: 12, fontSize: 11, fontWeight: 600 }}>🧹 Cleaning</span>
                  <span style={{ background: '#F0FDF4', color: '#22C55E', padding: '3px 10px', borderRadius: 12, fontSize: 11, fontWeight: 600 }}>🏪 Shop Helper</span>
                </div>
              </div>
            </div>
            <div style={{ marginTop: 10, display: 'flex', gap: 8, flexWrap: 'wrap' }}>
              <span style={{ fontSize: 13, color: '#22C55E', fontWeight: 600 }}>📍 Kodialbail — 🚶 6 min away</span>
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
              <span style={{ fontSize: 11, color: '#22C55E', background: '#F0FDF4', padding: '3px 8px', borderRadius: 8, fontWeight: 600 }}>✅ Phone Verified</span>
              <span style={{ fontSize: 11, color: '#22C55E', background: '#F0FDF4', padding: '3px 8px', borderRadius: 8, fontWeight: 600 }}>✅ Community Verified</span>
            </div>
          </div>

          {/* When can you start */}
          <div style={{ marginTop: 24 }}>
            <h3 style={{ fontSize: 16, fontWeight: 600, color: '#0F172A' }}>When can you start?</h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginTop: 12 }}>
              {['Today', 'Tomorrow', 'This Week', 'Discuss'].map(opt => (
                <button key={opt} onClick={() => setStartTime(opt)} style={{
                  height: 56, borderRadius: 12,
                  border: startTime === opt ? '2px solid #22C55E' : '1.5px solid #E2E8F0',
                  background: startTime === opt ? '#F0FDF4' : 'white',
                  color: '#0F172A', fontSize: 15, fontWeight: startTime === opt ? 700 : 500,
                  cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
                }}>
                  {startTime === opt && <Check size={18} color="#22C55E" style={{ marginRight: 8 }} />}
                  {opt}
                </button>
              ))}
            </div>
          </div>

          {/* Message */}
          <div style={{ marginTop: 24 }}>
            <h3 style={{ fontSize: 14, fontWeight: 600, color: '#0F172A' }}>Add a message (optional)</h3>
            <textarea
              placeholder="Hi, I am interested in this position. I have experience in shop work..."
              style={{
                width: '100%', height: 80, borderRadius: 12, border: '1.5px solid #E2E8F0',
                padding: '12px 16px', fontSize: 14, marginTop: 8, resize: 'none',
                fontFamily: 'inherit', outline: 'none', background: '#F8FAFC',
                boxSizing: 'border-box',
              }}
            />
            <p style={{ textAlign: 'right', fontSize: 12, color: '#94A3B8', marginTop: 4 }}>0/200</p>
          </div>
        </div>
      </div>

      {/* Bottom */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'white', padding: '12px 20px 28px',
        borderTop: '1px solid #E2E8F0',
      }}>
        <button onClick={() => setStep(2)} style={{
          width: '100%', height: 56, borderRadius: 12, background: '#22C55E',
          color: 'white', fontWeight: 700, fontSize: 16, border: 'none',
          cursor: 'pointer', boxShadow: '0 4px 16px rgba(34,197,94,0.3)',
        }}>
          Submit Application / ಅರ್ಜಿ ಸಲ್ಲಿಸಿ
        </button>
      </div>
    </div>
  )
}
