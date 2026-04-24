import { ArrowLeft, Share2, Bookmark, Star, CheckCircle, Clock, Users } from 'lucide-react'
import { WorkerNav } from '../components/BottomNav'

export default function JobDetail() {
  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 80 }}>
        {/* Hero Area */}
        <div style={{
          height: 200, position: 'relative',
          background: 'var(--color-primary-light)',
          display: 'flex', alignItems: 'center', justifyContent: 'center'
        }}>
          {/* Minimal Icon */}
          <div style={{ fontSize: 64, opacity: 0.5 }}>🏪</div>

          {/* Back & actions */}
          <div style={{
            position: 'absolute', top: 16, left: 16, right: 16,
            display: 'flex', justifyContent: 'space-between',
          }}>
            <button className="tap-feedback" style={{
              width: 40, height: 40, borderRadius: '50%', background: 'var(--color-card)',
              border: '1px solid var(--color-border)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <ArrowLeft size={20} color="var(--color-text)" />
            </button>
            <div style={{ display: 'flex', gap: 8 }}>
              <button className="tap-feedback" style={{
                width: 40, height: 40, borderRadius: '50%', background: 'var(--color-card)',
                border: '1px solid var(--color-border)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Share2 size={18} color="var(--color-text)" />
              </button>
              <button className="tap-feedback" style={{
                width: 40, height: 40, borderRadius: '50%', background: 'var(--color-card)',
                border: '1px solid var(--color-border)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Bookmark size={18} color="var(--color-text)" />
              </button>
            </div>
          </div>
        </div>

        {/* Job Header Card */}
        <div style={{
          background: 'var(--color-card)', borderRadius: '24px 24px 0 0', marginTop: -24,
          padding: '24px 20px 16px', position: 'relative',
          borderBottom: '1px solid var(--color-border)'
        }}>
          <h1 style={{ fontSize: 24, fontWeight: 800, color: 'var(--color-text)' }}>Shop Assistant</h1>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 8 }}>
            <span style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>Sri Ganesh Provision Store</span>
            <span style={{
              background: 'var(--color-primary-light)', color: 'var(--color-primary-dark)', fontSize: 11, fontWeight: 700,
              padding: '2px 8px', borderRadius: 12, display: 'flex', alignItems: 'center', gap: 4,
            }}><CheckCircle size={10} /> Verified</span>
          </div>
          <div style={{ fontSize: 14, color: 'var(--color-text-secondary)', marginTop: 6 }}>📍 Kodialbail Main Road, Mangalore</div>
          
          <div style={{ marginTop: 20 }}>
            <span style={{ fontSize: 28, fontWeight: 800, color: 'var(--color-text)' }}>₹12,000</span>
            <span style={{ fontSize: 16, color: 'var(--color-caption)' }}>/month</span>
          </div>
        </div>

        {/* Type pills */}
        <div style={{ background: 'var(--color-card)', padding: '0 20px 20px', display: 'flex', gap: 8, flexWrap: 'wrap', borderBottom: '1px solid var(--color-border)' }}>
          <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '6px 12px', borderRadius: 8, fontSize: 13, fontWeight: 600 }}>Full Time</span>
          <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '6px 12px', borderRadius: 8, fontSize: 13, fontWeight: 600 }}>Retail</span>
          <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '6px 12px', borderRadius: 8, fontSize: 13, fontWeight: 600 }}>Immediate Start</span>
        </div>

        {/* Quick Stats */}
        <div style={{ display: 'flex', gap: 12, padding: '20px 20px' }}>
          {[
            { icon: <Users size={20} color="var(--color-primary)" />, label: '2 Openings' },
            { icon: <Clock size={20} color="var(--color-primary)" />, label: '9AM-6PM' },
            { icon: <Star size={20} color="var(--color-primary)" />, label: '4.8 Rating' },
          ].map(s => (
            <div key={s.label} style={{
              flex: 1, background: 'var(--color-card)', borderRadius: 12, padding: '12px 8px',
              textAlign: 'center', border: '1px solid var(--color-border)'
            }}>
              <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 4 }}>{s.icon}</div>
              <div style={{ fontSize: 12, color: 'var(--color-text-secondary)', fontWeight: 600 }}>{s.label}</div>
            </div>
          ))}
        </div>

        {/* About */}
        <div style={{ padding: '0 20px 24px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)', marginBottom: 12 }}>About this Job</h3>
          <p style={{ fontSize: 14, color: 'var(--color-text-secondary)', lineHeight: 1.6 }}>
            Help manage a busy provision store in the heart of Kodialbail. Responsibilities include assisting customers,
            organizing shelves, handling billing, and maintaining cleanliness. A warm and friendly attitude is more important
            than formal qualifications.
          </p>
        </div>

        {/* Requirements */}
        <div style={{ padding: '0 20px 24px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)', marginBottom: 16 }}>
            Requirements
          </h3>
          {[
            { text: 'No degree or certificate required' },
            { text: 'Basic Kannada or Hindi communication' },
            { text: 'Honest, punctual, hardworking' },
            { text: 'Can lift boxes (up to 10kg)' },
            { text: 'Mobile phone for WhatsApp updates' },
          ].map((r, i) => (
            <div key={i} style={{ display: 'flex', alignItems: 'flex-start', gap: 12, marginBottom: 12 }}>
              <div style={{ marginTop: 2, color: 'var(--color-primary)' }}><CheckCircle size={16} /></div>
              <span style={{ fontSize: 14, color: 'var(--color-text)' }}>{r.text}</span>
            </div>
          ))}
        </div>

        {/* Perks */}
        <div style={{ padding: '0 20px 24px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)', marginBottom: 16 }}>
            What you get
          </h3>
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
            {['Free Lunch', 'Weekly Pay', 'Salary Hike', 'Bonus'].map(p => (
              <span key={p} style={{
                background: 'var(--color-card)', border: '1px solid var(--color-border)', color: 'var(--color-text)', padding: '8px 16px',
                borderRadius: 20, fontSize: 13, fontWeight: 600,
              }}>{p}</span>
            ))}
          </div>
        </div>

        {/* About Employer */}
        <div style={{ padding: '0 20px 24px' }}>
          <div style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '16px',
            border: '1px solid var(--color-border)', display: 'flex', gap: 16, alignItems: 'center',
          }}>
            <div style={{
              width: 48, height: 48, borderRadius: 12, background: 'var(--color-bg)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 20, fontWeight: 700, color: 'var(--color-text)', flexShrink: 0,
            }}>SG</div>
            <div>
              <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--color-text)' }}>Sri Ganesh Provision Store</div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 4, marginTop: 4 }}>
                <span style={{ fontSize: 13, color: 'var(--color-text-secondary)' }}>47 hired • Since 2022</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Bottom Action */}
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0,
        background: 'var(--color-card)', padding: '16px 20px 24px',
        borderTop: '1px solid var(--color-border)', display: 'flex', gap: 12,
      }}>
        <button className="tap-feedback" style={{
          width: 56, height: 56, borderRadius: 12, background: 'var(--color-bg)',
          border: '1px solid var(--color-border)', color: 'var(--color-text-secondary)',
          cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <Bookmark size={24} />
        </button>
        <button className="btn-primary tap-feedback" style={{ flex: 1 }}>
          Apply Now
        </button>
      </div>
    </div>
  )
}
