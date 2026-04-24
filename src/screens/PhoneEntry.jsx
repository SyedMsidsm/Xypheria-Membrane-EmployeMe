import { useState } from 'react'
import { ArrowLeft, Lock } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

export default function PhoneEntry() {
  const [step, setStep] = useState(1)
  const [otp] = useState(['4', '7', '2', ''])
  const navigate = useNavigate()

  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {step === 1 ? (
        <>
          {/* Header */}
          <div style={{ padding: '16px 20px', display: 'flex', alignItems: 'center' }}>
            <button onClick={() => navigate('/role')} style={{ background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <ArrowLeft size={20} color="var(--color-text)" />
            </button>
          </div>
          <div style={{ textAlign: 'center', padding: '0 20px', marginTop: 12 }}>
            <h1 style={{ fontSize: 26, fontWeight: 800, color: 'var(--color-text)' }}>Verify Your Number</h1>
            <p style={{ fontSize: 13, color: 'var(--color-caption)', marginTop: 6, fontWeight: 500 }}>ನಿಮ್ಮ ನಂಬರ್ ಪರಿಶೀಲಿಸಿ</p>
          </div>

          {/* Illustration */}
          <div style={{ display: 'flex', justifyContent: 'center', padding: '32px 0' }}>
            <div style={{
              width: 120, height: 120, borderRadius: '50%',
              background: 'var(--color-primary-light)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
                <rect x="16" y="6" width="28" height="48" rx="6" fill="var(--color-navy)" />
                <rect x="18" y="10" width="24" height="36" rx="3" fill="var(--color-navy-lighter)" />
                <circle cx="30" cy="50" r="2.5" fill="var(--color-text-secondary)" />
                {/* Signal waves */}
                <path d="M46 18 C50 14 50 26 46 22" stroke="var(--color-primary)" strokeWidth="2" fill="none" opacity="0.8" />
                <path d="M50 14 C56 8 56 30 50 24" stroke="var(--color-primary)" strokeWidth="2" fill="none" opacity="0.5" />
                <path d="M54 10 C62 2 62 34 54 26" stroke="var(--color-primary)" strokeWidth="2" fill="none" opacity="0.3" />
                {/* Check on screen */}
                <circle cx="30" cy="26" r="8" fill="var(--color-primary)" opacity="0.2" />
                <path d="M26 26L29 29L34 23" stroke="var(--color-primary)" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
            </div>
          </div>

          {/* Content */}
          <div style={{ padding: '0 24px' }}>
            <p style={{ fontSize: 16, fontWeight: 600, color: 'var(--color-text)' }}>Enter your mobile number</p>
            <p style={{ fontSize: 14, color: 'var(--color-text-secondary)', marginTop: 4 }}>We'll send a 4-digit verification code</p>

            {/* Phone Input */}
            <div style={{
              marginTop: 24, height: 64, borderRadius: 16,
              border: '2px solid var(--color-primary)', display: 'flex', alignItems: 'center',
              overflow: 'hidden', boxShadow: '0 4px 16px rgba(16,185,129,0.1)', background: 'var(--color-card)'
            }}>
              <div style={{
                width: 80, display: 'flex', alignItems: 'center', justifyContent: 'center',
                gap: 6, borderRight: '1px solid var(--color-border)', height: '100%', background: 'var(--color-bg)',
              }}>
                <span style={{ fontSize: 18 }}>🇮🇳</span>
                <span style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>+91</span>
              </div>
              <div style={{ flex: 1, padding: '0 16px' }}>
                <span style={{ fontSize: 20, fontWeight: 700, color: 'var(--color-text)', letterSpacing: 2 }}>
                  98765 43210
                </span>
              </div>
            </div>

            {/* Privacy note */}
            <div style={{
              display: 'flex', alignItems: 'center', gap: 8, marginTop: 16,
              background: 'var(--color-primary-light)', borderRadius: 12, padding: '10px 14px',
            }}>
              <Lock size={14} color="var(--color-primary-dark)" />
              <span style={{ fontSize: 12, color: 'var(--color-primary-dark)', fontWeight: 500 }}>
                Never shared publicly / ಸಾರ್ವಜನಿಕರಿಗೆ ಎಂದಿಗೂ ತಿಳಿಸುವುದಿಲ್ಲ
              </span>
            </div>
          </div>

          {/* Button */}
          <div style={{ padding: '28px 24px', marginTop: 'auto' }}>
            <button onClick={() => setStep(2)} className="btn-primary">
              <span style={{ marginRight: 8 }}>Send OTP</span>
              <span style={{ fontSize: 12, opacity: 0.8, fontWeight: 500 }}>OTP ಕಳಿಸಿ</span>
            </button>
          </div>
        </>
      ) : (
        <>
          {/* OTP Screen */}
          <div className="fade-in" style={{ padding: '16px 20px', display: 'flex', alignItems: 'center', height: '100%', flexDirection: 'column' }}>
            <div style={{ width: '100%', display: 'flex' }}>
              <button onClick={() => setStep(1)} style={{ background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <ArrowLeft size={20} color="var(--color-text)" />
              </button>
            </div>
            
            <div style={{ textAlign: 'center', padding: '0 20px', marginTop: 24, width: '100%' }}>
              <h1 style={{ fontSize: 26, fontWeight: 800, color: 'var(--color-text)' }}>Enter the 4-digit code</h1>
              <p style={{ fontSize: 13, color: 'var(--color-caption)', marginTop: 4, fontWeight: 500 }}>4-ಅಂಕೆಯ ಕೋಡ್ ನಮೂದಿಸಿ</p>
              <p style={{ fontSize: 15, color: 'var(--color-primary)', marginTop: 8, fontWeight: 600 }}>
                Sent to +91 98765 43210
              </p>
            </div>

            {/* OTP Boxes */}
            <div style={{ display: 'flex', justifyContent: 'center', gap: 12, padding: '40px 20px', width: '100%' }}>
              {[0, 1, 2, 3].map(i => (
                <div key={i} style={{
                  width: 64, height: 64, borderRadius: 16,
                  border: `2px solid ${i === 3 ? 'var(--color-primary)' : otp[i] ? 'var(--color-primary-light)' : 'var(--color-border)'}`,
                  background: otp[i] ? 'var(--color-primary-light)' : 'var(--color-card)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: 28, fontWeight: 700, color: 'var(--color-text)',
                  boxShadow: i === 3 ? '0 4px 16px rgba(16,185,129,0.1)' : 'none',
                  transition: 'all 0.2s ease',
                }}>
                  {otp[i]}
                  {i === 3 && !otp[i] && (
                    <div style={{
                      width: 2, height: 28, background: 'var(--color-primary)',
                      animation: 'pulse 1s infinite',
                    }} />
                  )}
                </div>
              ))}
            </div>

            {/* Resend timer */}
            <p style={{ textAlign: 'center', fontSize: 14, color: 'var(--color-text-secondary)', fontWeight: 500 }}>
              Resend OTP in <span style={{ color: 'var(--color-text)', fontWeight: 700 }}>28s</span>
            </p>

            {/* Verify Button */}
            <div style={{ padding: '28px 4px', marginTop: 'auto', width: '100%' }}>
              <button onClick={() => navigate('/skills')} className="btn-primary">
                <span style={{ marginRight: 8 }}>Verify</span>
                <span style={{ fontSize: 12, opacity: 0.8, fontWeight: 500 }}>ಪರಿಶೀಲಿಸಿ</span>
              </button>
            </div>
          </div>
        </>
      )}
    </div>
  )
}
