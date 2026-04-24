import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'

export default function SplashScreen() {
  const navigate = useNavigate()

  useEffect(() => {
    const timeout = setTimeout(() => navigate('/language'), 2500)
    return () => clearTimeout(timeout)
  }, [navigate])

  return (
    <div className="mobile-frame-inner fade-in" style={{
      background: 'var(--color-primary)',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      height: '100%',
      position: 'relative',
    }}>
      {/* Center content */}
      <div style={{
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        marginTop: -40,
      }}>
        {/* App Icon */}
        <div className="scale-pop" style={{
          width: 96, height: 96, borderRadius: 24, background: 'white',
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          boxShadow: '0 12px 32px rgba(0,0,0,0.1)',
        }}>
          <svg width="48" height="48" viewBox="0 0 48 48" fill="none">
            <path d="M8 28L14 22L20 26L28 18L34 22" stroke="var(--color-primary)" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round" />
            <path d="M14 22L10 26C8.5 27.5 8.5 30 10 31.5L16 37.5C17.5 39 20 39 21.5 37.5L24 35" stroke="var(--color-primary)" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round" />
            <path d="M34 22L38 26C39.5 27.5 39.5 30 38 31.5L32 37.5C30.5 39 28 39 26.5 37.5L24 35" stroke="var(--color-primary)" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round" />
            <circle cx="14" cy="16" r="4" stroke="var(--color-primary)" strokeWidth="2.5" fill="none" />
            <circle cx="34" cy="14" r="4" stroke="var(--color-primary)" strokeWidth="2.5" fill="none" />
            <path d="M18 16H30" stroke="var(--color-primary)" strokeWidth="2" strokeLinecap="round" strokeDasharray="3 3" />
          </svg>
        </div>

        {/* App Name */}
        <div style={{ marginTop: 24 }}>
          <h1 style={{
            fontSize: 36, fontWeight: 800, color: 'white',
            letterSpacing: '-1px', textAlign: 'center',
          }}>EmployMe</h1>
        </div>

        {/* Tagline */}
        <p style={{
          marginTop: 8, fontSize: 16, color: 'rgba(255,255,255,0.9)',
          textAlign: 'center', fontWeight: 500,
        }}>
          Hyperlocal Jobs for All
        </p>

        {/* Kannada tagline */}
        <p style={{
          marginTop: 6, fontSize: 13, color: 'rgba(255,255,255,0.7)',
          textAlign: 'center',
        }}>
          ಎಲ್ಲರಿಗೂ ಸ್ಥಳೀಯ ಉದ್ಯೋಗ
        </p>
      </div>

      {/* Made with love + tap to skip */}
      <p onClick={() => navigate('/language')} style={{
        position: 'absolute', bottom: 48, fontSize: 13,
        color: 'rgba(255,255,255,0.8)', textAlign: 'center',
        cursor: 'pointer', fontWeight: 500,
      }}>
        Made with ❤️ for Bharat
      </p>
    </div>
  )
}
