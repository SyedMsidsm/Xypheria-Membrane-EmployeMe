import { useState } from 'react'
import { Check } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

const languages = [
  { name: 'English', script: 'English', code: 'en' },
  { name: 'Kannada', script: 'ಕನ್ನಡ', code: 'kn' },
  { name: 'Hindi', script: 'हिंदी', code: 'hi' },
  { name: 'Telugu', script: 'తెలుగు', code: 'te' },
  { name: 'Malayalam', script: 'മലയാളം', code: 'ml' },
  { name: 'Tamil', script: 'தமிழ்', code: 'ta' },
]

export default function LanguageSelection() {
  const [selected, setSelected] = useState('kn')
  const navigate = useNavigate()

  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Header */}
      <div style={{ padding: '16px 20px 0' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <div style={{
            width: 32, height: 32, borderRadius: 10, background: 'var(--color-primary)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>
            <svg width="18" height="18" viewBox="0 0 48 48" fill="none">
              <path d="M8 28L14 22L20 26L28 18L34 22" stroke="white" strokeWidth="3.5" strokeLinecap="round" strokeLinejoin="round" />
              <path d="M14 22L10 26C8.5 27.5 8.5 30 10 31.5L16 37.5C17.5 39 20 39 21.5 37.5L24 35" stroke="white" strokeWidth="3.5" strokeLinecap="round" strokeLinejoin="round" />
              <path d="M34 22L38 26C39.5 27.5 39.5 30 38 31.5L32 37.5C30.5 39 28 39 26.5 37.5L24 35" stroke="white" strokeWidth="3.5" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </div>
          <span style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>EmployMe</span>
        </div>

        {/* Progress dots */}
        <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginTop: 16 }}>
          <div style={{ width: 12, height: 12, borderRadius: '50%', background: 'var(--color-primary)' }} />
          <div style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--color-border)', marginTop: 2 }} />
          <div style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--color-border)', marginTop: 2 }} />
        </div>
      </div>

      {/* Title */}
      <div style={{ textAlign: 'center', padding: '28px 20px 8px' }}>
        <h1 style={{ fontSize: 24, fontWeight: 800, color: 'var(--color-text)' }}>Choose Your Language</h1>
        <p style={{ fontSize: 14, color: 'var(--color-text-secondary)', marginTop: 6, fontWeight: 500 }}>
          ನಿಮ್ಮ ಭಾಷೆ ಆಯ್ಕೆ ಮಾಡಿ
        </p>
      </div>

      {/* Language Grid */}
      <div style={{
        padding: '16px 20px', flex: 1,
        display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12,
        alignContent: 'start',
      }}>
        {languages.map(lang => {
          const isSelected = selected === lang.code
          return (
            <button
              key={lang.code}
              onClick={() => setSelected(lang.code)}
              className="tap-feedback"
              style={{
                height: 80, borderRadius: 16,
                border: isSelected ? '2px solid var(--color-primary)' : '1px solid var(--color-border)',
                background: isSelected ? 'var(--color-primary-light)' : 'var(--color-card)',
                display: 'flex', flexDirection: 'column',
                alignItems: 'center', justifyContent: 'center',
                cursor: 'pointer', position: 'relative',
              }}
            >
              {/* Checkmark */}
              <div style={{
                position: 'absolute', top: 8, right: 8,
                width: 20, height: 20, borderRadius: '50%',
                background: isSelected ? 'var(--color-primary)' : 'transparent',
                border: isSelected ? 'none' : '2px solid var(--color-border)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                {isSelected && <Check size={12} color="white" strokeWidth={3} />}
              </div>
              <span style={{ fontSize: 18, fontWeight: 700, color: isSelected ? 'var(--color-primary-dark)' : 'var(--color-text)' }}>{lang.script}</span>
              <span style={{ fontSize: 13, color: isSelected ? 'var(--color-primary-dark)' : 'var(--color-text-secondary)', marginTop: 2, fontWeight: 500 }}>{lang.name}</span>
            </button>
          )
        })}
      </div>

      {/* Bottom */}
      <div style={{ padding: '0 20px 32px' }}>
        <p style={{ fontSize: 13, color: 'var(--color-caption)', textAlign: 'center', marginBottom: 16, fontWeight: 500 }}>
          More languages coming soon
        </p>
        <button onClick={() => navigate('/role')} className="btn-primary">
          <span style={{ marginRight: 8 }}>Continue</span>
          <span style={{ fontSize: 12, opacity: 0.8, fontWeight: 500 }}>ಮುಂದುವರಿಯಿರಿ</span>
        </button>
      </div>
    </div>
  )
}
