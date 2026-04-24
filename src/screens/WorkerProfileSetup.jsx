import { ArrowLeft, Camera, Upload, Minus, Plus } from 'lucide-react'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

export default function WorkerProfileSetup() {
  const [exp, setExp] = useState(3)
  const [langs, setLangs] = useState(new Set(['Kannada', 'Hindi']))
  const navigate = useNavigate()

  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 100 }}>
        {/* Completion Banner */}
        <div style={{
          background: 'var(--color-navy)',
          padding: '24px 20px', margin: 0,
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <button onClick={() => navigate('/location')} style={{ background: 'rgba(255,255,255,0.1)', borderRadius: '50%', padding: 8, border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <ArrowLeft size={20} color="white" />
            </button>
          </div>
          <div style={{ marginTop: 16 }}>
            <p style={{ fontSize: 20, fontWeight: 800, color: 'white' }}>Complete your profile</p>
            <p style={{ fontSize: 13, color: 'rgba(255,255,255,0.7)', marginTop: 4 }}>Get 3x more job views!</p>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginTop: 16 }}>
              <div style={{ flex: 1, height: 6, borderRadius: 3, background: 'rgba(255,255,255,0.2)' }}>
                <div style={{ width: '60%', height: '100%', borderRadius: 3, background: 'var(--color-primary)' }} />
              </div>
              <span style={{ fontSize: 12, color: 'white', fontWeight: 700 }}>60%</span>
            </div>
          </div>
        </div>

        {/* Profile Photo */}
        <div style={{ padding: '32px 20px 0', textAlign: 'center' }}>
          <div style={{
            width: 100, height: 100, borderRadius: '50%', margin: '0 auto',
            border: '2px dashed var(--color-primary)', display: 'flex',
            flexDirection: 'column', alignItems: 'center', justifyContent: 'center',
            background: 'var(--color-primary-light)',
          }}>
            <Camera size={28} color="var(--color-primary)" />
          </div>
          <div style={{ display: 'flex', gap: 8, justifyContent: 'center', marginTop: 16 }}>
            <button className="tap-feedback" style={{
              padding: '10px 20px', borderRadius: 12, border: '1px solid var(--color-border)',
              background: 'var(--color-card)', fontSize: 13, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6,
              fontWeight: 600, color: 'var(--color-text)'
            }}>
              <Camera size={16} /> Take Photo
            </button>
            <button className="tap-feedback" style={{
              padding: '10px 20px', borderRadius: 12, border: '1px solid var(--color-border)',
              background: 'var(--color-card)', fontSize: 13, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6,
              fontWeight: 600, color: 'var(--color-text)'
            }}>
              <Upload size={16} /> Upload
            </button>
          </div>
        </div>

        {/* Form */}
        <div style={{ padding: '24px 20px 0' }}>
          {/* Full Name */}
          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginBottom: 8 }}>
            Full Name
          </label>
          <input type="text" className="input-field" defaultValue="Raju Kumar" style={{
            width: '100%', height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
            background: 'var(--color-card)', padding: '0 16px', fontSize: 15, color: 'var(--color-text)',
            outline: 'none', boxSizing: 'border-box',
          }} />

          {/* Age + Gender */}
          <div style={{ display: 'flex', gap: 12, marginTop: 20 }}>
            <div style={{ flex: 1 }}>
              <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginBottom: 8 }}>
                Age
              </label>
              <input type="number" className="input-field" defaultValue="24" style={{
                width: '100%', height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
                background: 'var(--color-card)', padding: '0 16px', fontSize: 15, color: 'var(--color-text)',
                outline: 'none', boxSizing: 'border-box',
              }} />
            </div>
            <div style={{ flex: 1 }}>
              <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginBottom: 8 }}>
                Gender
              </label>
              <select className="input-field" style={{
                width: '100%', height: 56, borderRadius: 12, border: '1px solid var(--color-border)',
                background: 'var(--color-card)', padding: '0 16px', fontSize: 15, color: 'var(--color-text)',
                outline: 'none', boxSizing: 'border-box', appearance: 'none',
              }}>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
              </select>
            </div>
          </div>

          {/* About */}
          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginTop: 20, marginBottom: 8 }}>
            About Yourself <span style={{ color: 'var(--color-caption)', fontWeight: 500 }}>(optional)</span>
          </label>
          <textarea className="input-field" placeholder="Tell employers about yourself and your experience..." style={{
            width: '100%', height: 100, borderRadius: 12, border: '1px solid var(--color-border)',
            background: 'var(--color-card)', padding: '16px', fontSize: 14, color: 'var(--color-text)',
            outline: 'none', resize: 'none', fontFamily: 'inherit', boxSizing: 'border-box',
          }} />
        </div>

        {/* Experience */}
        <div style={{ padding: '24px 20px 0' }}>
          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginBottom: 12 }}>
            Years of Experience
          </label>
          <div style={{ display: 'flex', alignItems: 'center', gap: 16, justifyContent: 'center' }}>
            <button className="tap-feedback" onClick={() => setExp(Math.max(0, exp - 1))} style={{
              width: 48, height: 48, borderRadius: 12, border: '1px solid var(--color-border)',
              background: 'var(--color-card)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <Minus size={20} color="var(--color-text-secondary)" />
            </button>
            <span style={{ fontSize: 20, fontWeight: 800, color: 'var(--color-text)', minWidth: 80, textAlign: 'center' }}>
              {exp} years
            </span>
            <button className="tap-feedback" onClick={() => setExp(exp + 1)} style={{
              width: 48, height: 48, borderRadius: 12, border: '1px solid var(--color-border)',
              background: 'var(--color-card)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <Plus size={20} color="var(--color-text-secondary)" />
            </button>
          </div>
        </div>

        {/* Languages */}
        <div style={{ padding: '24px 20px 0' }}>
          <label style={{ fontSize: 13, fontWeight: 700, color: 'var(--color-text)', display: 'block', marginBottom: 12 }}>
            Languages you speak
          </label>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
            {['Kannada', 'Hindi', 'English', 'Tamil', 'Telugu'].map(l => {
              const sel = langs.has(l)
              return (
                <button key={l} className="tap-feedback" onClick={() => {
                  setLangs(prev => {
                    const n = new Set(prev)
                    if (n.has(l)) n.delete(l); else n.add(l)
                    return n
                  })
                }} style={{
                  padding: '8px 16px', borderRadius: 20,
                  border: sel ? '1px solid var(--color-primary)' : '1px solid var(--color-border)',
                  background: sel ? 'var(--color-primary)' : 'var(--color-card)',
                  color: sel ? 'white' : 'var(--color-text)',
                  fontSize: 13, fontWeight: 600, cursor: 'pointer',
                }}>
                  {sel ? '✓ ' : ''}{l}
                </button>
              )
            })}
          </div>
        </div>

        {/* Emergency Contact */}
        <div style={{ padding: '24px 20px 24px' }}>
          <div className="card-shadow" style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '20px',
            border: '1px solid var(--color-border)', borderLeft: '4px solid var(--color-alert)',
          }}>
            <div style={{ fontSize: 15, fontWeight: 800, color: 'var(--color-text)' }}>Add Emergency Contact</div>
            <p style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 4 }}>Builds trust with employers</p>
            <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
              <input className="input-field" placeholder="Name" style={{
                flex: 1, height: 44, borderRadius: 10, border: '1px solid var(--color-border)', background: 'var(--color-bg)',
                padding: '0 12px', fontSize: 13, outline: 'none', boxSizing: 'border-box',
              }} />
              <input className="input-field" placeholder="Phone" style={{
                flex: 1, height: 44, borderRadius: 10, border: '1px solid var(--color-border)', background: 'var(--color-bg)',
                padding: '0 12px', fontSize: 13, outline: 'none', boxSizing: 'border-box',
              }} />
            </div>
          </div>
        </div>
      </div>

      {/* Bottom */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'var(--color-card)', padding: '16px 20px 24px',
        borderTop: '1px solid var(--color-border)',
      }}>
        <p onClick={() => navigate('/home')} className="tap-feedback" style={{ textAlign: 'center', fontSize: 14, color: 'var(--color-text-secondary)', marginBottom: 16, cursor: 'pointer', fontWeight: 600 }}>
          Skip for now
        </p>
        <button onClick={() => navigate('/home')} className="btn-primary">
          Save Profile
        </button>
      </div>
    </div>
  )
}
