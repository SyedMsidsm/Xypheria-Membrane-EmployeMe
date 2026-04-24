import { Search, Edit, CheckCircle } from 'lucide-react'
import { WorkerNav } from '../components/BottomNav'

export default function ChatList() {
  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 72 }}>
        {/* Header */}
        <div style={{ padding: '24px 20px 16px', background: 'var(--color-card)', borderBottom: '1px solid var(--color-border)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div>
              <h1 style={{ fontSize: 24, fontWeight: 800, color: 'var(--color-text)' }}>Messages</h1>
            </div>
            <button className="tap-feedback" style={{
              width: 44, height: 44, borderRadius: '50%', background: 'var(--color-bg)',
              border: '1px solid var(--color-border)', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <Edit size={20} color="var(--color-text)" />
            </button>
          </div>
          <div className="input-field" style={{
            marginTop: 20, height: 48, borderRadius: 12, background: 'var(--color-bg)',
            border: '1px solid var(--color-border)', display: 'flex', alignItems: 'center', padding: '0 16px', gap: 12,
          }}>
            <Search size={20} color="var(--color-text-secondary)" />
            <span style={{ fontSize: 15, color: 'var(--color-text-secondary)', fontWeight: 500 }}>Search conversations...</span>
          </div>
        </div>

        {/* Conversations */}
        {/* Conversation 1 - Unread */}
        <div className="tap-feedback" style={{
          padding: '16px 20px', background: 'var(--color-primary-light)',
          display: 'flex', gap: 16, alignItems: 'center',
          borderBottom: '1px solid var(--color-border)', cursor: 'pointer'
        }}>
          <div style={{ position: 'relative', flexShrink: 0 }}>
            <div style={{
              width: 56, height: 56, borderRadius: '50%', background: 'var(--color-primary)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 20, fontWeight: 800, color: 'white',
            }}>SG</div>
            <div style={{
              position: 'absolute', bottom: 0, right: 0, width: 14, height: 14,
              borderRadius: '50%', background: 'var(--color-primary)', border: '2px solid white',
            }} />
          </div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Sri Ganesh Store</span>
                <span style={{ color: 'var(--color-primary)', display: 'flex' }}><CheckCircle size={14} /></span>
              </div>
              <span style={{ fontSize: 13, color: 'var(--color-primary)', fontWeight: 700 }}>2 min</span>
            </div>
            <div style={{ fontSize: 13, color: 'var(--color-primary)', fontWeight: 700, marginTop: 4 }}>Re: Shop Assistant</div>
            <div style={{
              fontSize: 14, color: 'var(--color-text)', fontWeight: 600, marginTop: 2,
              overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap',
            }}>Please come tomorrow at 9 AM...</div>
          </div>
          <div style={{
            width: 24, height: 24, borderRadius: '50%', background: 'var(--color-primary)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 12, fontWeight: 800, color: 'white', flexShrink: 0,
          }}>2</div>
        </div>

        {/* Conversation 2 - Unread */}
        <div className="tap-feedback" style={{
          padding: '16px 20px', background: 'var(--color-primary-light)',
          display: 'flex', gap: 16, alignItems: 'center',
          borderBottom: '1px solid var(--color-border)', cursor: 'pointer'
        }}>
          <div style={{
            width: 56, height: 56, borderRadius: '50%', background: 'var(--color-navy)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 20, fontWeight: 800, color: 'white', flexShrink: 0,
          }}>HU</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Hotel Udupi Delights</span>
                <span style={{ color: 'var(--color-primary)', display: 'flex' }}><CheckCircle size={14} /></span>
              </div>
              <span style={{ fontSize: 13, color: 'var(--color-primary)', fontWeight: 700 }}>1 hr</span>
            </div>
            <div style={{ fontSize: 13, color: 'var(--color-navy)', fontWeight: 700, marginTop: 4 }}>Re: Kitchen Helper</div>
            <div style={{
              fontSize: 14, color: 'var(--color-text)', fontWeight: 600, marginTop: 2,
              overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap',
            }}>We'd like to offer you the...</div>
          </div>
          <div style={{
            width: 24, height: 24, borderRadius: '50%', background: 'var(--color-primary)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 12, fontWeight: 800, color: 'white', flexShrink: 0,
          }}>1</div>
        </div>

        {/* Conversation 3 - Read */}
        <div className="tap-feedback" style={{
          padding: '16px 20px', background: 'var(--color-card)',
          display: 'flex', gap: 16, alignItems: 'center',
          borderBottom: '1px solid var(--color-border)', cursor: 'pointer'
        }}>
          <div style={{
            width: 56, height: 56, borderRadius: '50%', background: 'var(--color-alert)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 20, fontWeight: 800, color: 'white', flexShrink: 0,
          }}>FM</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <span style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>FreshMart Grocery</span>
                <span style={{ color: 'var(--color-primary)', display: 'flex' }}><CheckCircle size={14} /></span>
              </div>
              <span style={{ fontSize: 13, color: 'var(--color-text-secondary)', fontWeight: 500 }}>Yesterday</span>
            </div>
            <div style={{
              fontSize: 14, color: 'var(--color-text-secondary)', marginTop: 4,
              overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap',
            }}>Thank you for applying, we will...</div>
          </div>
        </div>

        {/* Conversation 4 - Offer Pending */}
        <div className="tap-feedback" style={{
          padding: '16px 20px', background: 'var(--color-card)',
          display: 'flex', gap: 16, alignItems: 'center',
          borderBottom: '1px solid var(--color-border)', borderLeft: '4px solid var(--color-alert)', cursor: 'pointer'
        }}>
          <div style={{
            width: 56, height: 56, borderRadius: '50%', background: 'var(--color-navy-lighter)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 20, fontWeight: 800, color: 'white', flexShrink: 0,
          }}>QM</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <span style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>QuickMart</span>
              <span style={{
                background: 'var(--color-bg)', border: '1px solid var(--color-alert)', color: 'var(--color-alert)', fontSize: 10, fontWeight: 800,
                padding: '4px 8px', borderRadius: 12,
              }}>OFFER PENDING</span>
            </div>
            <div style={{ fontSize: 14, color: 'var(--color-text-secondary)', marginTop: 4 }}>Job offer sent. Waiting for...</div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 4 }}>
              <span style={{ fontSize: 12, color: 'var(--color-caption)' }}>3 days ago</span>
              <span style={{ fontSize: 13, color: 'var(--color-alert)', fontWeight: 700 }}>Respond →</span>
            </div>
          </div>
        </div>

        {/* Older section */}
        <div style={{ padding: '24px 20px 8px' }}>
          <span style={{ fontSize: 13, color: 'var(--color-caption)', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Older</span>
        </div>
        <div className="tap-feedback" style={{
          padding: '16px 20px', background: 'var(--color-card)',
          display: 'flex', gap: 16, alignItems: 'center', opacity: 0.6, cursor: 'pointer'
        }}>
          <div style={{
            width: 56, height: 56, borderRadius: '50%', background: 'var(--color-bg)',
            border: '1px solid var(--color-border)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 20, fontWeight: 800, color: 'var(--color-caption)', flexShrink: 0,
          }}>KS</div>
          <div>
            <span style={{ fontSize: 16, fontWeight: 600, color: 'var(--color-text-secondary)' }}>Kiran's Bakery</span>
            <div style={{ fontSize: 14, color: 'var(--color-caption)', marginTop: 4 }}>Thanks for your time</div>
          </div>
        </div>
      </div>

      <WorkerNav active="messages" />
    </div>
  )
}
