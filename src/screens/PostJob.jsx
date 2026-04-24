import { ArrowLeft, Minus, Plus } from 'lucide-react'
import { useState } from 'react'

export default function PostJob() {
  const [people, setPeople] = useState(2)
  const [urgent, setUrgent] = useState(false)

  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 100 }}>
        {/* Header */}
        <div style={{ background: 'var(--color-card)', padding: '16px 20px', borderBottom: '1px solid var(--color-border)' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <button className="tap-feedback" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 8, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <ArrowLeft size={20} color="var(--color-text)" />
            </button>
            <div style={{ flex: 1, textAlign: 'center' }}>
              <div style={{ fontSize: 18, fontWeight: 800, color: 'var(--color-text)' }}>Post a Job</div>
            </div>
            <div style={{ width: 38 }} />
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginTop: 16 }}>
            <span style={{ fontSize: 12, color: 'var(--color-text-secondary)', fontWeight: 600 }}>Step 1 of 2</span>
            <div style={{ flex: 1, height: 4, borderRadius: 2, background: 'var(--color-border)' }}>
              <div style={{ width: '50%', height: '100%', borderRadius: 2, background: 'var(--color-primary)' }} />
            </div>
          </div>
        </div>

        {/* Form */}
        <div style={{ padding: '24px 20px' }}>
          {/* Section 1 */}
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 20 }}>
            <div style={{ width: 24, height: 24, borderRadius: '50%', background: 'var(--color-primary-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 12, fontWeight: 800, color: 'var(--color-primary-dark)' }}>1</div>
            <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Job Details</span>
          </div>

          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginBottom: 8 }}>
            Job Title <span style={{ color: 'var(--color-alert)' }}>*</span>
          </label>
          <input type="text" className="input-field" placeholder="e.g. Shop Helper" style={{
            width: '100%', height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
            background: 'var(--color-card)', padding: '0 16px', fontSize: 15, outline: 'none', boxSizing: 'border-box',
          }} />
          <div style={{ display: 'flex', gap: 8, marginTop: 12, flexWrap: 'wrap' }}>
            {['Shop Helper', 'Cook', 'Delivery', 'Cleaner'].map(s => (
              <button key={s} className="tap-feedback" style={{
                padding: '8px 16px', borderRadius: 12, background: 'var(--color-bg)',
                border: '1px solid var(--color-border)', fontSize: 13, color: 'var(--color-text-secondary)', cursor: 'pointer', fontWeight: 600
              }}>{s}</button>
            ))}
          </div>

          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginTop: 24, marginBottom: 8 }}>
            Category <span style={{ color: 'var(--color-alert)' }}>*</span>
          </label>
          <div className="input-field" style={{
            width: '100%', height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
            background: 'var(--color-card)', padding: '0 16px', display: 'flex', alignItems: 'center',
            justifyContent: 'space-between', boxSizing: 'border-box',
          }}>
            <span style={{ fontSize: 15, color: 'var(--color-text)', fontWeight: 600 }}>Retail & Shop</span>
            <span style={{ color: 'var(--color-text-secondary)' }}>▼</span>
          </div>

          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginTop: 24, marginBottom: 16 }}>
            Number of people needed
          </label>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 24 }}>
            <button className="tap-feedback" onClick={() => setPeople(Math.max(1, people - 1))} style={{
              width: 56, height: 56, borderRadius: 16, border: '1px solid var(--color-border)',
              background: 'var(--color-card)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}><Minus size={24} color="var(--color-text)" /></button>
            <div style={{ textAlign: 'center', width: 80 }}>
              <span style={{ fontSize: 36, fontWeight: 800, color: 'var(--color-text)' }}>{people}</span>
            </div>
            <button className="tap-feedback" onClick={() => setPeople(people + 1)} style={{
              width: 56, height: 56, borderRadius: 16, border: '1px solid var(--color-border)',
              background: 'var(--color-card)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}><Plus size={24} color="var(--color-text)" /></button>
          </div>

          {/* Section 2 - Pay */}
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 40, marginBottom: 20 }}>
            <div style={{ width: 24, height: 24, borderRadius: '50%', background: 'var(--color-primary-light)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 12, fontWeight: 800, color: 'var(--color-primary-dark)' }}>2</div>
            <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Pay & Timing</span>
          </div>

          <div style={{
            display: 'flex', borderRadius: 12, border: '1px solid var(--color-border)', overflow: 'hidden', background: 'var(--color-card)'
          }}>
            <div style={{
              width: 48, background: 'var(--color-bg)', display: 'flex', alignItems: 'center',
              justifyContent: 'center', fontSize: 18, fontWeight: 800, color: 'var(--color-primary)', borderRight: '1px solid var(--color-border)',
            }}>₹</div>
            <input type="text" className="input-field" defaultValue="500" style={{
              flex: 1, height: 56, border: 'none', padding: '0 16px', background: 'transparent',
              fontSize: 18, fontWeight: 800, outline: 'none', color: 'var(--color-text)'
            }} />
            <div style={{
              padding: '0 16px', background: 'var(--color-bg)', display: 'flex', alignItems: 'center',
              borderLeft: '1px solid var(--color-border)', fontSize: 14, color: 'var(--color-text-secondary)', gap: 8, fontWeight: 600
            }}>
              per day <span style={{ color: 'var(--color-caption)', fontSize: 10 }}>▼</span>
            </div>
          </div>

          <div style={{ display: 'flex', gap: 12, marginTop: 20 }}>
            <div style={{ flex: 1 }}>
              <label style={{ fontSize: 12, color: 'var(--color-text-secondary)', display: 'block', marginBottom: 8, fontWeight: 600 }}>From</label>
              <div className="input-field" style={{
                height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 15, fontWeight: 700, color: 'var(--color-text)', background: 'var(--color-card)',
              }}>9:00 AM</div>
            </div>
            <div style={{ flex: 1 }}>
              <label style={{ fontSize: 12, color: 'var(--color-text-secondary)', display: 'block', marginBottom: 8, fontWeight: 600 }}>To</label>
              <div className="input-field" style={{
                height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 15, fontWeight: 700, color: 'var(--color-text)', background: 'var(--color-card)',
              }}>6:00 PM</div>
            </div>
          </div>

          <div style={{ display: 'flex', gap: 0, marginTop: 20, border: '1px solid var(--color-border)', borderRadius: 12, overflow: 'hidden' }}>
            {['Full Time', 'Part Time', 'Daily Wage'].map((t, i) => (
              <button key={t} className="tap-feedback" style={{
                flex: 1, padding: '12px 0', border: 'none',
                background: i === 1 ? 'var(--color-primary)' : 'var(--color-card)',
                color: i === 1 ? 'white' : 'var(--color-text-secondary)',
                fontSize: 13, fontWeight: 700, cursor: 'pointer',
                borderRight: i < 2 ? '1px solid var(--color-border)' : 'none',
              }}>{t}</button>
            ))}
          </div>

          {/* Description */}
          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginTop: 32, marginBottom: 8 }}>
            Describe the work
          </label>
          <textarea className="input-field" defaultValue="Help manage daily shop operations including customer service, billing, and shelf organization."
            style={{
              width: '100%', height: 120, borderRadius: 12, border: '1px solid var(--color-border)',
              padding: '16px', fontSize: 14, resize: 'none', fontFamily: 'inherit',
              outline: 'none', boxSizing: 'border-box', background: 'var(--color-card)', color: 'var(--color-text)'
            }}
          />
          <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 12, alignItems: 'center' }}>
            <button className="tap-feedback" style={{
              padding: '10px 16px', borderRadius: 12, border: '1px solid var(--color-border)',
              background: 'var(--color-bg)', color: 'var(--color-primary)', fontSize: 13, fontWeight: 700, cursor: 'pointer', display: 'flex', gap: 6, alignItems: 'center'
            }}>✨ Generate Description</button>
            <span style={{ fontSize: 12, color: 'var(--color-caption)', fontWeight: 500 }}>47/300</span>
          </div>

          {/* Requirements */}
          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginTop: 32, marginBottom: 12 }}>
            What do you need? <span style={{ color: 'var(--color-caption)', fontWeight: 500 }}>(optional)</span>
          </label>
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
            {['Kannada speaking', 'Physically fit'].map(r => (
              <span key={r} style={{
                background: 'var(--color-primary-light)', color: 'var(--color-primary-dark)', padding: '8px 16px',
                borderRadius: 20, fontSize: 13, fontWeight: 700, display: 'flex', alignItems: 'center', gap: 6
              }}>{r} <span style={{ cursor: 'pointer', fontSize: 16 }}>×</span></span>
            ))}
            <button className="tap-feedback" style={{
              padding: '8px 16px', borderRadius: 20, border: '1px dashed var(--color-border)',
              background: 'var(--color-card)', color: 'var(--color-text-secondary)', fontSize: 13, cursor: 'pointer', fontWeight: 600
            }}>+ Add requirement</button>
          </div>

          {/* Urgency */}
          <div className="card-shadow tap-feedback" style={{
            background: 'var(--color-card)', borderRadius: 16, border: '1px solid var(--color-border)', borderLeft: '4px solid var(--color-alert)',
            padding: '20px', marginTop: 32,
            display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          }}>
            <div>
              <div style={{ fontSize: 15, fontWeight: 800, color: 'var(--color-text)' }}>Need someone urgently? ⚡</div>
              <div style={{ fontSize: 12, color: 'var(--color-text-secondary)', marginTop: 4 }}>Your job shows as 🔴 HIRING TODAY</div>
            </div>
            <button onClick={() => setUrgent(!urgent)} style={{
              width: 52, height: 32, borderRadius: 16,
              background: urgent ? 'var(--color-alert)' : 'var(--color-bg)',
              border: urgent ? 'none' : '1px solid var(--color-border)', cursor: 'pointer', position: 'relative',
            }}>
              <div style={{
                width: 24, height: 24, borderRadius: '50%', background: 'white',
                position: 'absolute', top: urgent ? 4 : 3,
                left: urgent ? 24 : 3,
                transition: 'left 0.2s',
                boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
              }} />
            </button>
          </div>
        </div>
      </div>

      {/* Bottom */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'var(--color-card)', padding: '16px 20px 24px',
        borderTop: '1px solid var(--color-border)', display: 'flex', gap: 12,
      }}>
        <button className="tap-feedback" style={{
          flex: 1, height: 56, borderRadius: 12, background: 'var(--color-bg)',
          border: '1px solid var(--color-border)', color: 'var(--color-text)', fontWeight: 700,
          fontSize: 15, cursor: 'pointer',
        }}>Preview</button>
        <button className="btn-primary tap-feedback" style={{ flex: 2 }}>
          Continue
        </button>
      </div>
    </div>
  )
}
