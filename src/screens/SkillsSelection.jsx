import { useState } from 'react'
import { ArrowLeft } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

const skills = [
  { emoji: '🍳', name: 'Cooking', kn: 'ಅಡುಗೆ' },
  { emoji: '🧹', name: 'Cleaning', kn: 'ಸ್ವಚ್ಛತೆ' },
  { emoji: '🚚', name: 'Delivery', kn: 'ಡೆಲಿವರಿ' },
  { emoji: '🏪', name: 'Shop Helper', kn: 'ಅಂಗಡಿ' },
  { emoji: '👷', name: 'Labour', kn: 'ಕೂಲಿ' },
  { emoji: '🌱', name: 'Farming', kn: 'ಕೃಷಿ' },
  { emoji: '👶', name: 'Childcare', kn: 'ಮಕ್ಕಳ' },
  { emoji: '👵', name: 'Elder Care', kn: 'ವೃದ್ಧರು' },
  { emoji: '🔧', name: 'Repair', kn: 'ದುರಸ್ತಿ' },
  { emoji: '🚗', name: 'Driving', kn: 'ಚಾಲನೆ' },
  { emoji: '💇', name: 'Beauty', kn: 'ಸೌಂದರ್ಯ' },
  { emoji: '📦', name: 'Packing', kn: 'ಪ್ಯಾಕಿಂಗ್' },
  { emoji: '🛡️', name: 'Security', kn: 'ಭದ್ರತೆ' },
  { emoji: '📱', name: 'Data Entry', kn: 'ಡೇಟಾ' },
  { emoji: '🎨', name: 'Painting', kn: 'ಬಣ್ಣ' },
  { emoji: '🧵', name: 'Tailoring', kn: 'ಹೊಲಿಗೆ' },
]

const defaultSelected = ['Cooking', 'Cleaning', 'Delivery', 'Shop Helper']

export default function SkillsSelection() {
  const [selected, setSelected] = useState(new Set(defaultSelected))
  const navigate = useNavigate()

  const toggle = (name) => {
    setSelected(prev => {
      const next = new Set(prev)
      if (next.has(name)) next.delete(name)
      else next.add(name)
      return next
    })
  }

  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Header */}
      <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <button onClick={() => navigate('/phone')} style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 8, marginLeft: -8 }}>
            <ArrowLeft size={22} color="#0F172A" />
          </button>
          <span style={{ fontSize: 13, color: '#64748B' }}>Step 2 of 3</span>
        </div>
        {/* Progress bar */}
        <div style={{ display: 'flex', gap: 4, marginTop: 12 }}>
          <div style={{ flex: 1, height: 4, borderRadius: 2, background: '#22C55E' }} />
          <div style={{ flex: 1, height: 4, borderRadius: 2, background: 'linear-gradient(90deg, #22C55E 60%, #E2E8F0 60%)' }} />
          <div style={{ flex: 1, height: 4, borderRadius: 2, background: '#E2E8F0' }} />
        </div>
      </div>

      {/* Title */}
      <div style={{ padding: '20px 20px 0' }}>
        <h1 style={{ fontSize: 24, fontWeight: 700, color: '#0F172A' }}>What can you do?</h1>
        <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>ನೀವು ಏನು ಮಾಡಬಲ್ಲಿರಿ?</p>
        <p style={{ fontSize: 14, color: '#22C55E', fontWeight: 600, marginTop: 6 }}>
          Tap all that apply — no degree needed!
        </p>
        <p style={{ fontSize: 12, color: '#64748B', marginTop: 2 }}>
          ಡಿಗ್ರಿ ಬೇಡ, ನಿಮ್ಮ ಕೌಶಲ್ಯ ಸಾಕು
        </p>

        {/* Counter */}
        <div style={{
          display: 'inline-flex', alignItems: 'center', gap: 6,
          background: '#F0FDF4', border: '1px solid #22C55E',
          borderRadius: 20, padding: '6px 14px', marginTop: 12,
        }}>
          <span style={{ fontSize: 14, fontWeight: 700, color: '#22C55E' }}>
            {selected.size} skills selected
          </span>
        </div>
      </div>

      {/* Skills Grid */}
      <div style={{
        flex: 1, overflow: 'auto', padding: '16px 16px 100px',
        display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)',
        gap: 10, alignContent: 'start',
      }}>
        {skills.map(skill => {
          const isSelected = selected.has(skill.name)
          return (
            <button
              key={skill.name}
              onClick={() => toggle(skill.name)}
              className={isSelected ? 'scale-pop' : ''}
              style={{
                width: '100%', height: 80, borderRadius: 16,
                border: isSelected ? '2px solid #22C55E' : '1.5px solid #E2E8F0',
                background: isSelected ? '#22C55E' : 'white',
                display: 'flex', flexDirection: 'column',
                alignItems: 'center', justifyContent: 'center', gap: 3,
                cursor: 'pointer', transition: 'all 0.15s ease',
                padding: 4,
              }}
            >
              <span style={{ fontSize: 26 }}>{skill.emoji}</span>
              <span style={{
                fontSize: 11, fontWeight: 700,
                color: isSelected ? 'white' : '#0F172A',
                lineHeight: 1.1, textAlign: 'center',
              }}>{skill.name}</span>
              <span style={{
                fontSize: 9,
                color: isSelected ? 'rgba(255,255,255,0.8)' : '#94A3B8',
                lineHeight: 1.1,
              }}>{skill.kn}</span>
            </button>
          )
        })}
      </div>

      {/* Bottom Fixed */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'white', padding: '12px 20px 28px',
        borderTop: '1px solid #E2E8F0',
      }}>
        <p style={{ textAlign: 'center', marginBottom: 12 }}>
          <span style={{ fontSize: 14, color: '#22C55E', fontWeight: 600, cursor: 'pointer' }}>
            Can't find your skill? Add it +
          </span>
        </p>
        <button onClick={() => navigate('/location')} className="tap-feedback" style={{
          width: '100%', height: 56, borderRadius: 12, background: '#22C55E',
          color: 'white', fontWeight: 700, fontSize: 16, border: 'none',
          cursor: 'pointer', boxShadow: '0 4px 16px rgba(34,197,94,0.3)',
        }}>
          Continue / ಮುಂದುವರಿಯಿರಿ
        </button>
      </div>
    </div>
  )
}
