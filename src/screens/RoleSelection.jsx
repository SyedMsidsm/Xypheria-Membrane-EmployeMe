import { ChevronRight } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

export default function RoleSelection() {
  const navigate = useNavigate()
  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Top Illustration Area */}
      <div style={{
        height: '35%', background: 'linear-gradient(180deg, var(--color-primary-light) 0%, rgba(209,250,229,0.2) 100%)',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        position: 'relative', overflow: 'hidden', borderBottom: '1px solid var(--color-border)',
      }}>
        {/* Simplified aesthetic illustration */}
        <svg width="240" height="180" viewBox="0 0 240 180" fill="none">
          <circle cx="120" cy="90" r="60" fill="var(--color-primary)" opacity="0.1" />
          <circle cx="120" cy="90" r="40" fill="var(--color-primary)" opacity="0.2" />
          <rect x="80" y="70" width="30" height="40" rx="6" fill="var(--color-primary)" />
          <rect x="130" y="60" width="30" height="50" rx="6" fill="var(--color-info)" />
          <path d="M110 90 L130 90" stroke="var(--color-text)" strokeWidth="3" strokeDasharray="4 4" strokeLinecap="round" />
        </svg>
      </div>

      {/* Middle text */}
      <div style={{ textAlign: 'center', padding: '24px 24px 0' }}>
        <h1 style={{ fontSize: 26, fontWeight: 800, color: 'var(--color-text)', letterSpacing: '-0.5px' }}>Welcome to EmployMe</h1>
        <p style={{ fontSize: 15, color: 'var(--color-text-secondary)', marginTop: 8, maxWidth: 280, margin: '8px auto 0', lineHeight: 1.5, fontWeight: 500 }}>
          Find nearby work or hire trusted local staff
        </p>
        <p style={{ fontSize: 13, color: 'var(--color-caption)', marginTop: 4, fontWeight: 500 }}>EmployMe ಗೆ ಸ್ವಾಗತ</p>
      </div>

      {/* Role cards */}
      <div style={{ padding: '24px 20px 0', display: 'flex', flexDirection: 'column', gap: 16, flex: 1 }}>
        {/* Worker Card */}
        <button onClick={() => navigate('/phone')} className="tap-feedback card-shadow" style={{
          background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: 16,
          padding: 20, display: 'flex', alignItems: 'center', gap: 14,
          cursor: 'pointer', textAlign: 'left', transition: 'all 0.2s ease',
        }}>
          <div style={{
            width: 52, height: 52, borderRadius: '50%', background: 'var(--color-primary-light)',
            display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
          }}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--color-primary-dark)" strokeWidth="2" strokeLinecap="round">
              <circle cx="12" cy="5" r="3" />
              <path d="M12 8v6M8 20l2-6h4l2 6" />
              <path d="M7 13l-2 3M17 13l2 3" />
            </svg>
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 18, fontWeight: 700, color: 'var(--color-text)' }}>Looking for Work</div>
            <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 4, fontWeight: 500 }}>No resume needed • Local jobs</div>
            <div style={{ fontSize: 12, color: 'var(--color-primary)', marginTop: 4, fontWeight: 600 }}>ಕೆಲಸ ಹುಡುಕುತ್ತಿದ್ದೇನೆ</div>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 6, flexShrink: 0 }}>
            <span style={{
              background: 'var(--color-primary)', color: 'white', fontSize: 11, fontWeight: 700,
              padding: '4px 10px', borderRadius: 20,
            }}>FREE</span>
            <ChevronRight size={18} color="var(--color-primary)" />
          </div>
        </button>

        {/* Employer Card */}
        <button onClick={() => navigate('/employer')} className="tap-feedback card-shadow" style={{
          background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: 16,
          padding: 20, display: 'flex', alignItems: 'center', gap: 14,
          cursor: 'pointer', textAlign: 'left', transition: 'all 0.2s ease',
        }}>
          <div style={{
            width: 52, height: 52, borderRadius: '50%', background: 'rgba(59,130,246,0.1)',
            display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
          }}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--color-info)" strokeWidth="2" strokeLinecap="round">
              <rect x="4" y="8" width="16" height="12" rx="2" />
              <path d="M4 14h16M8 8V6a2 2 0 012-2h4a2 2 0 012 2v2" />
            </svg>
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 18, fontWeight: 700, color: 'var(--color-text)' }}>I'm Hiring</div>
            <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 4, fontWeight: 500 }}>Post jobs • Find workers</div>
            <div style={{ fontSize: 12, color: 'var(--color-info)', marginTop: 4, fontWeight: 600 }}>ನೇಮಕಾತಿ ಮಾಡುತ್ತಿದ್ದೇನೆ</div>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 6, flexShrink: 0 }}>
            <ChevronRight size={18} color="var(--color-caption)" />
          </div>
        </button>
      </div>

      {/* Bottom */}
      <div style={{ padding: '16px 20px 28px', textAlign: 'center' }}>
        <p style={{ fontSize: 14, color: 'var(--color-text-secondary)', fontWeight: 500 }}>
          Already have an account?{' '}
          <span onClick={() => navigate('/phone')} style={{ color: 'var(--color-primary)', fontWeight: 700, cursor: 'pointer' }}>Sign In</span>
        </p>
        <p style={{ fontSize: 12, color: 'var(--color-caption)', marginTop: 8, fontWeight: 500 }}>
          By continuing you agree to our Terms & Privacy Policy
        </p>
      </div>
    </div>
  )
}
