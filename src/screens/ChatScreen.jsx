import { ArrowLeft, Phone, MoreVertical, Paperclip, Smile, Send, CheckCircle, Info, Check, X } from 'lucide-react'
import { useNavigate } from 'react-router-dom'

export default function ChatScreen() {
  const navigate = useNavigate()
  
  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      {/* Chat Header */}
      <div style={{
        background: 'var(--color-card)', padding: '12px 16px',
        borderBottom: '1px solid var(--color-border)',
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <button className="tap-feedback" onClick={() => navigate(-1)} style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 8, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <ArrowLeft size={20} color="var(--color-text)" />
          </button>
          <div style={{
            width: 44, height: 44, borderRadius: '50%', background: 'var(--color-primary)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 16, fontWeight: 800, color: 'white', flexShrink: 0,
          }}>SG</div>
          <div style={{ flex: 1 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
              <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Sri Ganesh Store</span>
              <span style={{ color: 'var(--color-primary)', display: 'flex' }}><CheckCircle size={14} /></span>
            </div>
            <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', fontWeight: 500, marginTop: 2 }}>Re: Shop Assistant</div>
          </div>
          <button className="tap-feedback" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 8, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <Phone size={18} color="var(--color-text)" />
          </button>
          <button className="tap-feedback" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 8, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <MoreVertical size={18} color="var(--color-text)" />
          </button>
        </div>
      </div>

      {/* Job Context Pill */}
      <div style={{
        margin: '12px 16px', background: 'var(--color-primary-light)', borderRadius: 12, padding: '12px 16px',
        display: 'flex', alignItems: 'center', gap: 12, border: '1px solid var(--color-border)'
      }}>
        <span style={{ fontSize: 16 }}>🏪</span>
        <span style={{ fontSize: 14, fontWeight: 700, color: 'var(--color-text)' }}>Shop Assistant</span>
        <span style={{ fontSize: 14, fontWeight: 800, color: 'var(--color-primary)' }}>₹12,000/mo</span>
        <span style={{ background: 'var(--color-primary)', color: 'white', fontSize: 10, fontWeight: 800, padding: '4px 8px', borderRadius: 8 }}>Active</span>
      </div>

      {/* Messages */}
      <div style={{ flex: 1, overflow: 'auto', padding: '8px 16px', paddingBottom: 120 }}>
        {/* System message */}
        <div style={{ textAlign: 'center', marginBottom: 20 }}>
          <span style={{
            fontSize: 12, color: 'var(--color-text-secondary)', background: 'var(--color-card)', border: '1px solid var(--color-border)',
            padding: '6px 16px', borderRadius: 20, fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: 6
          }}>
            <Info size={14} /> Chat started • Nov 12, 2025
          </span>
        </div>

        {/* Employer msg 1 */}
        <div style={{ display: 'flex', gap: 8, marginBottom: 16 }}>
          <div style={{
            width: 32, height: 32, borderRadius: '50%', background: 'var(--color-primary-light)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 12, fontWeight: 800, color: 'var(--color-primary-dark)', flexShrink: 0, marginTop: 'auto',
          }}>SG</div>
          <div>
            <div style={{
              background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: '16px 16px 16px 4px',
              padding: '12px 16px', maxWidth: 260, fontSize: 14, color: 'var(--color-text)', lineHeight: 1.5,
            }}>
              Hello! I saw your application for Shop Assistant. Are you available to start soon?
            </div>
            <span style={{ fontSize: 11, color: 'var(--color-caption)', marginTop: 6, display: 'block', marginLeft: 8, fontWeight: 600 }}>10:32 AM</span>
          </div>
        </div>

        {/* Worker msg 1 */}
        <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 16 }}>
          <div>
            <div style={{
              background: 'var(--color-primary)', borderRadius: '16px 16px 4px 16px',
              padding: '12px 16px', maxWidth: 260, fontSize: 14, color: 'white', lineHeight: 1.5,
            }}>
              Yes, I can start immediately. I have 2 years experience in similar work.
            </div>
            <span style={{ fontSize: 11, color: 'var(--color-caption)', marginTop: 6, display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: 4, marginRight: 8, fontWeight: 600 }}>10:34 AM <span style={{ color: 'var(--color-primary)' }}>✓✓</span></span>
          </div>
        </div>

        {/* Employer msg 2 */}
        <div style={{ display: 'flex', gap: 8, marginBottom: 16 }}>
          <div style={{
            width: 32, height: 32, borderRadius: '50%', background: 'var(--color-primary-light)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 12, fontWeight: 800, color: 'var(--color-primary-dark)', flexShrink: 0, marginTop: 'auto',
          }}>SG</div>
          <div>
            <div style={{
              background: 'var(--color-card)', border: '1px solid var(--color-border)', borderRadius: '16px 16px 16px 4px',
              padding: '12px 16px', maxWidth: 260, fontSize: 14, color: 'var(--color-text)', lineHeight: 1.5,
            }}>
              Great! Can you come for a quick meeting tomorrow at the shop?
            </div>
            <span style={{ fontSize: 11, color: 'var(--color-caption)', marginTop: 6, display: 'block', marginLeft: 8, fontWeight: 600 }}>10:35 AM</span>
          </div>
        </div>

        {/* Worker msg 2 */}
        <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 24 }}>
          <div>
            <div style={{
              background: 'var(--color-primary)', borderRadius: '16px 16px 4px 16px',
              padding: '12px 16px', maxWidth: 260, fontSize: 14, color: 'white', lineHeight: 1.5,
            }}>
              Yes, what time? 🚶 I'm only 6 minutes away!
            </div>
            <span style={{ fontSize: 11, color: 'var(--color-caption)', marginTop: 6, display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: 4, marginRight: 8, fontWeight: 600 }}>10:36 AM <span style={{ color: 'var(--color-primary)' }}>✓✓</span></span>
          </div>
        </div>

        {/* Job Offer Card */}
        <div className="card-shadow" style={{
          background: 'var(--color-card)', borderRadius: 16, overflow: 'hidden',
          marginBottom: 16, border: '1px solid var(--color-border)'
        }}>
          <div style={{
            background: 'var(--color-primary)',
            padding: '12px 16px', textAlign: 'center',
          }}>
            <span style={{ fontSize: 15, fontWeight: 800, color: 'white', letterSpacing: '0.05em' }}>🎉 JOB OFFER</span>
          </div>
          <div style={{ padding: '20px' }}>
            <div style={{ fontSize: 18, fontWeight: 800, color: 'var(--color-text)' }}>Shop Assistant</div>
            <div style={{ fontSize: 14, color: 'var(--color-text-secondary)', marginTop: 6, fontWeight: 600 }}>₹12,000/month • Full Time</div>
            
            <div style={{ background: 'var(--color-bg)', padding: '12px', borderRadius: 12, marginTop: 12 }}>
              <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', fontWeight: 500 }}>Start: <span style={{ color: 'var(--color-text)', fontWeight: 700 }}>Monday, Nov 14</span></div>
              <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', fontWeight: 500, marginTop: 4 }}>Hours: <span style={{ color: 'var(--color-text)', fontWeight: 700 }}>9 AM – 6 PM, Mon–Sat</span></div>
            </div>
            
            <div style={{ display: 'flex', gap: 12, marginTop: 20 }}>
              <button className="tap-feedback btn-primary" style={{
                flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
                padding: '12px 0'
              }}><Check size={18} /> Accept</button>
              <button className="tap-feedback" style={{
                flex: 1, borderRadius: 12, background: 'var(--color-card)',
                border: '1px solid var(--color-alert)', color: 'var(--color-alert)', fontWeight: 700, fontSize: 14, cursor: 'pointer',
                display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6
              }}><X size={18} /> Decline</button>
            </div>
            <p style={{ textAlign: 'center', fontSize: 12, color: 'var(--color-alert)', marginTop: 12, fontWeight: 700 }}>
              Offer expires in 24 hours
            </p>
          </div>
        </div>
        <span style={{ display: 'block', textAlign: 'center', fontSize: 12, color: 'var(--color-caption)', marginBottom: 20, fontWeight: 600 }}>Nov 12 • 10:45 AM</span>

        {/* Phone Reveal Card */}
        <div style={{
          background: 'var(--color-card)', borderRadius: 16, border: '1px dashed var(--color-border)',
          padding: '20px', marginBottom: 16,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
            <span style={{ fontSize: 16 }}>🔒</span>
            <span style={{ fontSize: 15, fontWeight: 800, color: 'var(--color-text)' }}>Share your phone number?</span>
          </div>
          <p style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginBottom: 6, lineHeight: 1.5 }}>Sri Ganesh Store wants to contact you directly.</p>
          <p style={{ fontSize: 12, color: 'var(--color-caption)', fontWeight: 600 }}>📞 Your number stays private until you accept</p>
          <div style={{ display: 'flex', gap: 12, marginTop: 16 }}>
            <button className="tap-feedback" style={{
              flex: 1, padding: '12px 0', borderRadius: 12, background: 'var(--color-primary)',
              color: 'white', fontSize: 13, fontWeight: 800, border: 'none', cursor: 'pointer',
            }}>Share Number</button>
            <button className="tap-feedback" style={{
              flex: 1, padding: '12px 0', borderRadius: 12, background: 'var(--color-card)',
              border: '1px solid var(--color-border)', color: 'var(--color-text-secondary)', fontSize: 13, fontWeight: 700, cursor: 'pointer',
            }}>Keep Hidden</button>
          </div>
        </div>
      </div>

      {/* Quick Reply Chips */}
      <div style={{
        padding: '12px 16px', background: 'var(--color-card)', borderTop: '1px solid var(--color-border)',
        display: 'flex', gap: 8, overflow: 'auto', scrollbarWidth: 'none',
      }}>
        {['Yes, I\'m interested 👍', 'When do I start?', 'What\'s the pay?', 'I\'m on my way'].map(chip => (
          <button key={chip} className="tap-feedback" style={{
            padding: '8px 16px', borderRadius: 20, border: '1px solid var(--color-border)',
            background: 'var(--color-bg)', fontSize: 13, color: 'var(--color-text-secondary)', cursor: 'pointer',
            whiteSpace: 'nowrap', flexShrink: 0, fontWeight: 600
          }}>{chip}</button>
        ))}
      </div>

      {/* Input Bar */}
      <div style={{
        padding: '12px 16px 24px', background: 'var(--color-card)',
        display: 'flex', alignItems: 'center', gap: 12,
      }}>
        <button className="tap-feedback" style={{ background: 'var(--color-bg)', border: '1px solid var(--color-border)', borderRadius: '50%', cursor: 'pointer', padding: 8, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
          <Paperclip size={20} color="var(--color-text-secondary)" />
        </button>
        <div className="input-field" style={{
          flex: 1, height: 48, borderRadius: 24, background: 'var(--color-bg)', border: '1px solid var(--color-border)',
          display: 'flex', alignItems: 'center', padding: '0 16px', gap: 12,
        }}>
          <span style={{ flex: 1, fontSize: 15, color: 'var(--color-caption)', fontWeight: 500 }}>Type a message...</span>
          <Smile size={20} color="var(--color-text-secondary)" style={{ cursor: 'pointer' }} />
        </div>
        <button className="tap-feedback" style={{
          width: 48, height: 48, borderRadius: '50%', background: 'var(--color-primary)',
          border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0
        }}>
          <Send size={20} color="white" />
        </button>
      </div>
    </div>
  )
}
