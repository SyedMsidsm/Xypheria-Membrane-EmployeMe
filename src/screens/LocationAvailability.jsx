import { useState } from 'react'
import { ArrowLeft, MapPin } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
const timings = [
  { emoji: '🌅', label: 'Morning' },
  { emoji: '☀️', label: 'Afternoon' },
  { emoji: '🌆', label: 'Evening' },
  { emoji: '🌙', label: 'Any Time' },
]

export default function LocationAvailability() {
  const [selectedDays, setSelectedDays] = useState(new Set(['Mon', 'Tue', 'Wed', 'Thu', 'Fri']))
  const [travel, setTravel] = useState('walk')
  const [timing, setTiming] = useState('Morning')
  const [available, setAvailable] = useState(true)
  const navigate = useNavigate()

  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Header */}
      <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <button onClick={() => navigate('/skills')} style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 8, marginLeft: -8 }}>
            <ArrowLeft size={22} color="#0F172A" />
          </button>
          <span style={{ fontSize: 13, color: '#64748B' }}>Step 3 of 3</span>
        </div>
        <div style={{ display: 'flex', gap: 4, marginTop: 12 }}>
          <div style={{ flex: 1, height: 4, borderRadius: 2, background: '#22C55E' }} />
          <div style={{ flex: 1, height: 4, borderRadius: 2, background: '#22C55E' }} />
          <div style={{ flex: 1, height: 4, borderRadius: 2, background: 'linear-gradient(90deg, #22C55E 70%, #E2E8F0 70%)' }} />
        </div>
      </div>

      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 100 }}>
        {/* Title */}
        <div style={{ padding: '16px 20px 0' }}>
          <h1 style={{ fontSize: 24, fontWeight: 700, color: '#0F172A' }}>Where are you available?</h1>
          <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>ನೀವು ಎಲ್ಲಿ ಲಭ್ಯರಿದ್ದೀರಿ?</p>
          <p style={{ fontSize: 14, color: '#22C55E', fontWeight: 500, marginTop: 4 }}>
            Jobs will be shown within walking distance
          </p>
        </div>

        {/* Map */}
        <div style={{ padding: '12px 20px' }}>
          <div style={{
            height: 180, borderRadius: 16, overflow: 'hidden',
            background: 'linear-gradient(135deg, #E8F5E9, #C8E6C9, #A5D6A7)',
            position: 'relative', border: '1px solid #E2E8F0',
          }}>
            {/* Grid lines for map effect */}
            <svg width="100%" height="100%" style={{ position: 'absolute' }}>
              {[...Array(12)].map((_, i) => (
                <line key={`h${i}`} x1="0" y1={i * 16} x2="100%" y2={i * 16} stroke="#81C784" strokeWidth="0.5" opacity="0.3" />
              ))}
              {[...Array(24)].map((_, i) => (
                <line key={`v${i}`} x1={i * 16} y1="0" x2={i * 16} y2="100%" stroke="#81C784" strokeWidth="0.5" opacity="0.3" />
              ))}
              {/* Roads */}
              <line x1="60" y1="0" x2="60" y2="100%" stroke="#FFFFFF" strokeWidth="4" opacity="0.5" />
              <line x1="0" y1="90" x2="100%" y2="90" stroke="#FFFFFF" strokeWidth="4" opacity="0.5" />
              <line x1="200" y1="40" x2="300" y2="140" stroke="#FFFFFF" strokeWidth="3" opacity="0.4" />
            </svg>

            {/* Coverage circle */}
            <div style={{
              position: 'absolute', top: '50%', left: '50%',
              transform: 'translate(-50%, -50%)',
              width: 120, height: 120, borderRadius: '50%',
              background: 'rgba(34,197,94,0.12)',
              border: '2px solid rgba(34,197,94,0.3)',
            }} />

            {/* Pulse animation rings */}
            <div style={{
              position: 'absolute', top: '50%', left: '50%',
              transform: 'translate(-50%, -50%)',
              width: 24, height: 24, borderRadius: '50%',
              background: 'rgba(34,197,94,0.3)',
            }} className="pulse-ring" />

            {/* Center pin */}
            <div style={{
              position: 'absolute', top: '50%', left: '50%',
              transform: 'translate(-50%, -100%)',
            }}>
              <div style={{
                width: 32, height: 40, display: 'flex', flexDirection: 'column', alignItems: 'center',
              }}>
                <div style={{
                  width: 28, height: 28, borderRadius: '50%',
                  background: '#22C55E', border: '3px solid white',
                  boxShadow: '0 4px 12px rgba(0,0,0,0.2)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                }}>
                  <MapPin size={14} color="white" fill="white" />
                </div>
                <div style={{
                  width: 0, height: 0,
                  borderLeft: '6px solid transparent',
                  borderRight: '6px solid transparent',
                  borderTop: '8px solid #22C55E',
                  marginTop: -2,
                }} />
              </div>
            </div>
          </div>
        </div>

        {/* Location Card */}
        <div style={{ padding: '0 20px' }}>
          <div style={{
            background: 'white', borderRadius: 16, border: '1.5px solid #22C55E',
            padding: '14px 16px', display: 'flex', alignItems: 'center', gap: 12,
          }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#F0FDF4',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <MapPin size={20} color="#22C55E" />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>Kodialbail, Mangalore</div>
              <div style={{ fontSize: 13, color: '#64748B' }}>Karnataka 575003</div>
            </div>
            <span style={{ fontSize: 13, color: '#22C55E', fontWeight: 600, cursor: 'pointer' }}>Change</span>
          </div>
        </div>

        {/* Travel Distance */}
        <div style={{ padding: '16px 20px 0' }}>
          <p style={{ fontSize: 14, fontWeight: 600, color: '#0F172A' }}>How far will you travel?</p>
          <p style={{ fontSize: 12, color: '#64748B', marginTop: 2 }}>ಎಷ್ಟು ದೂರ ಹೋಗಬಲ್ಲಿರಿ?</p>
          <div style={{
            display: 'flex', gap: 0, marginTop: 10,
            border: '1.5px solid #E2E8F0', borderRadius: 12, overflow: 'hidden',
          }}>
            {[
              { id: 'walk', emoji: '🚶', label: 'Walk', sub: '500m' },
              { id: 'nearby', emoji: '🛺', label: 'Nearby', sub: '2km' },
              { id: 'any', emoji: '🚌', label: 'Any', sub: '5km+' },
            ].map(opt => (
              <button key={opt.id} onClick={() => setTravel(opt.id)} style={{
                flex: 1, padding: '10px 0', border: 'none',
                background: travel === opt.id ? '#22C55E' : 'white',
                color: travel === opt.id ? 'white' : '#0F172A',
                cursor: 'pointer', display: 'flex', flexDirection: 'column',
                alignItems: 'center', gap: 2, borderRight: '1px solid #E2E8F0',
              }}>
                <span style={{ fontSize: 18 }}>{opt.emoji}</span>
                <span style={{ fontSize: 12, fontWeight: 600 }}>{opt.label}</span>
                <span style={{ fontSize: 10, opacity: 0.8 }}>{opt.sub}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Availability Days */}
        <div style={{ padding: '16px 20px 0' }}>
          <p style={{ fontSize: 14, fontWeight: 600, color: '#0F172A' }}>When are you available?</p>
          <p style={{ fontSize: 12, color: '#64748B', marginTop: 2 }}>ಯಾವಾಗ ಲಭ್ಯರಿದ್ದೀರಿ?</p>
          <div style={{ display: 'flex', gap: 8, marginTop: 10, justifyContent: 'space-between' }}>
            {days.map(day => {
              const isSelected = selectedDays.has(day)
              return (
                <button key={day} onClick={() => {
                  setSelectedDays(prev => {
                    const next = new Set(prev)
                    if (next.has(day)) next.delete(day); else next.add(day)
                    return next
                  })
                }} style={{
                  width: 40, height: 40, borderRadius: '50%',
                  border: isSelected ? '2px solid #22C55E' : '1.5px solid #E2E8F0',
                  background: isSelected ? '#22C55E' : 'white',
                  color: isSelected ? 'white' : '#0F172A',
                  fontSize: 12, fontWeight: 700, cursor: 'pointer',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                }}>
                  {day}
                </button>
              )
            })}
          </div>
        </div>

        {/* Time Preference */}
        <div style={{ padding: '16px 20px 0' }}>
          <p style={{ fontSize: 14, fontWeight: 600, color: '#0F172A' }}>Preferred timing</p>
          <p style={{ fontSize: 12, color: '#64748B', marginTop: 2 }}>ಆದ್ಯತೆಯ ಸಮಯ</p>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, marginTop: 10 }}>
            {timings.map(t => (
              <button key={t.label} onClick={() => setTiming(t.label)} style={{
                padding: '8px 14px', borderRadius: 20,
                border: timing === t.label ? '1.5px solid #22C55E' : '1.5px solid #E2E8F0',
                background: timing === t.label ? '#22C55E' : 'white',
                color: timing === t.label ? 'white' : '#0F172A',
                fontSize: 13, fontWeight: 600, cursor: 'pointer',
              }}>
                {t.emoji} {t.label}
              </button>
            ))}
          </div>
        </div>

        {/* Available Now */}
        <div style={{ padding: '16px 20px' }}>
          <div style={{
            background: '#F0FDF4', borderRadius: 16, padding: '16px',
            display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          }}>
            <div>
              <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>Available Right Now?</div>
              <div style={{ fontSize: 12, color: '#22C55E', marginTop: 2 }}>ಈಗ ಕೆಲಸಕ್ಕೆ ತಯಾರಿದ್ದೀರಾ?</div>
              {available && (
                <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 6 }}>
                  <div style={{ width: 8, height: 8, borderRadius: '50%', background: '#22C55E' }} className="pulse-ring" />
                  <span style={{ fontSize: 12, color: '#22C55E' }}>Employers can see you're ready!</span>
                </div>
              )}
            </div>
            <button onClick={() => setAvailable(!available)} style={{
              width: 52, height: 28, borderRadius: 14,
              background: available ? '#22C55E' : '#E2E8F0',
              border: 'none', cursor: 'pointer', position: 'relative',
              transition: 'background 0.2s',
            }}>
              <div style={{
                width: 24, height: 24, borderRadius: '50%', background: 'white',
                position: 'absolute', top: 2,
                left: available ? 26 : 2,
                transition: 'left 0.2s',
                boxShadow: '0 1px 3px rgba(0,0,0,0.2)',
              }} />
            </button>
          </div>
        </div>
      </div>

      {/* Bottom Fixed */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'white', padding: '12px 20px 28px',
        borderTop: '1px solid #E2E8F0',
      }}>
        <button onClick={() => navigate('/profile-setup')} className="tap-feedback" style={{
          width: '100%', height: 56, borderRadius: 12, background: '#22C55E',
          color: 'white', fontWeight: 700, fontSize: 16, border: 'none',
          cursor: 'pointer', boxShadow: '0 4px 16px rgba(34,197,94,0.3)',
        }}>
          Continue / ಮುಂದುವರಿಯಿರಿ 🎉
        </button>
      </div>
    </div>
  )
}
