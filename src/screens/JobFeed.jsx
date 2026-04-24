import { Bell, Search, SlidersHorizontal, ChevronRight, MapPin } from 'lucide-react'
import { WorkerNav } from '../components/BottomNav'

export default function JobFeed() {
  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 72 }}>
        {/* Top App Bar */}
        <div style={{
          background: 'var(--color-card)', padding: '14px 20px',
          borderBottom: '1px solid var(--color-border)',
        }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
              <div style={{
                width: 36, height: 36, borderRadius: '50%', background: 'var(--color-primary-light)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 16, fontWeight: 700, color: 'var(--color-primary-dark)',
              }}>R</div>
              <span style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>Hi, Raju</span>
            </div>

            <div style={{
              display: 'flex', alignItems: 'center', gap: 6,
              background: 'var(--color-bg)', borderRadius: 20, padding: '6px 12px', cursor: 'pointer',
            }}>
              <MapPin size={12} color="var(--color-text-secondary)" />
              <span style={{ fontSize: 13, fontWeight: 600, color: 'var(--color-text)' }}>Kodialbail</span>
            </div>

            <div style={{ position: 'relative', cursor: 'pointer' }}>
              <Bell size={22} color="var(--color-text)" />
              <div style={{
                position: 'absolute', top: -4, right: -4,
                width: 18, height: 18, borderRadius: '50%', background: 'var(--color-alert)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 10, fontWeight: 700, color: 'white', border: '2px solid var(--color-card)'
              }}>3</div>
            </div>
          </div>
        </div>

        {/* Search + Filter */}
        <div style={{ padding: '16px 20px 0', display: 'flex', gap: 8 }}>
          <div style={{
            flex: 1, height: 48, borderRadius: 12, background: 'var(--color-card)',
            display: 'flex', alignItems: 'center', padding: '0 14px', gap: 8,
            border: '1px solid var(--color-border)',
          }}>
            <Search size={18} color="var(--color-caption)" />
            <input type="text" placeholder="Search jobs..." style={{
              border: 'none', background: 'transparent', flex: 1, fontSize: 14, color: 'var(--color-text)', outline: 'none'
            }} />
          </div>
          <button className="tap-feedback" style={{
            width: 48, height: 48, borderRadius: 12, background: 'var(--color-primary)',
            border: 'none', cursor: 'pointer', display: 'flex',
            alignItems: 'center', justifyContent: 'center',
          }}>
            <SlidersHorizontal size={18} color="white" />
          </button>
        </div>

        {/* Urgent Jobs Banner */}
        <div style={{ padding: '16px 20px 0' }}>
          <div className="tap-feedback" style={{
            background: 'var(--color-navy)',
            borderRadius: 16, padding: '16px',
            display: 'flex', alignItems: 'center',
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12, flex: 1 }}>
              <div style={{
                width: 40, height: 40, borderRadius: '50%', background: 'rgba(255,255,255,0.1)',
                display: 'flex', alignItems: 'center', justifyContent: 'center'
              }}>
                <span style={{ fontSize: 20 }}>🔥</span>
              </div>
              <div>
                <div style={{ fontSize: 15, fontWeight: 700, color: 'white' }}>Urgent Hiring</div>
                <div style={{ fontSize: 13, color: 'rgba(255,255,255,0.7)', marginTop: 2 }}>3 jobs near you need immediate joiners</div>
              </div>
            </div>
            <ChevronRight size={20} color="rgba(255,255,255,0.5)" />
          </div>
        </div>

        {/* Category Filter */}
        <div style={{
          padding: '20px 20px 0', display: 'flex', gap: 8,
          overflow: 'auto', scrollbarWidth: 'none',
        }}>
          {[
            { label: 'All Jobs', active: true },
            { label: 'Cooking' }, { label: 'Delivery' },
            { label: 'Cleaning' }, { label: 'Shop' },
            { label: 'Labour' }, { label: 'Repair' },
          ].map(cat => (
            <button key={cat.label} style={{
              padding: '8px 16px', borderRadius: 20, whiteSpace: 'nowrap',
              border: '1px solid',
              borderColor: cat.active ? 'var(--color-primary)' : 'var(--color-border)',
              background: cat.active ? 'var(--color-primary)' : 'var(--color-card)',
              color: cat.active ? 'white' : 'var(--color-text)',
              fontSize: 13, fontWeight: 600, cursor: 'pointer', flexShrink: 0,
            }}>
              {cat.label}
            </button>
          ))}
        </div>

        {/* Jobs Header */}
        <div style={{
          padding: '24px 20px 12px',
          display: 'flex', justifyContent: 'space-between', alignItems: 'center',
        }}>
          <span style={{ fontSize: 18, fontWeight: 800, color: 'var(--color-text)' }}>Recommended for you</span>
        </div>

        {/* Job Cards */}
        <div style={{ padding: '0 20px 20px', display: 'flex', flexDirection: 'column', gap: 12 }}>
          {/* Card 1 */}
          <div className="card-shadow tap-feedback" style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)',
          }}>
            <div style={{ display: 'flex', gap: 12 }}>
              <div style={{
                width: 48, height: 48, borderRadius: 12, background: 'var(--color-bg)',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24, flexShrink: 0,
              }}>🏪</div>
              <div style={{ flex: 1 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                  <div>
                    <div style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>Shop Assistant</div>
                    <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 2 }}>Sri Ganesh Provision Store</div>
                  </div>
                </div>
                <div style={{ display: 'flex', gap: 6, marginTop: 8, flexWrap: 'wrap' }}>
                  <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '4px 8px', borderRadius: 6, fontSize: 12, fontWeight: 500 }}>Full Time</span>
                  <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '4px 8px', borderRadius: 6, fontSize: 12, fontWeight: 500 }}>Kodialbail</span>
                </div>
              </div>
            </div>
            
            <div style={{
              display: 'flex', justifyContent: 'space-between', alignItems: 'center',
              marginTop: 16, paddingTop: 16, borderTop: '1px solid var(--color-border)',
            }}>
              <div>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>₹12,000</span>
                <span style={{ fontSize: 12, color: 'var(--color-caption)' }}>/mo</span>
              </div>
              <button style={{
                padding: '8px 20px', borderRadius: 8, background: 'var(--color-primary-light)',
                color: 'var(--color-primary-dark)', fontSize: 13, fontWeight: 700, border: 'none', cursor: 'pointer',
              }}>Apply</button>
            </div>
          </div>

          {/* Card 2 */}
          <div className="card-shadow tap-feedback" style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)',
          }}>
            <div style={{ display: 'flex', gap: 12 }}>
              <div style={{
                width: 48, height: 48, borderRadius: 12, background: 'var(--color-bg)',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24, flexShrink: 0,
              }}>🍳</div>
              <div style={{ flex: 1 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                  <div>
                    <div style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>Kitchen Helper</div>
                    <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 2 }}>Hotel Udupi Delights</div>
                  </div>
                </div>
                <div style={{ display: 'flex', gap: 6, marginTop: 8, flexWrap: 'wrap' }}>
                  <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '4px 8px', borderRadius: 6, fontSize: 12, fontWeight: 500 }}>Part Time</span>
                  <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '4px 8px', borderRadius: 6, fontSize: 12, fontWeight: 500 }}>Hampankatta</span>
                </div>
              </div>
            </div>
            
            <div style={{
              display: 'flex', justifyContent: 'space-between', alignItems: 'center',
              marginTop: 16, paddingTop: 16, borderTop: '1px solid var(--color-border)',
            }}>
              <div>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>₹500</span>
                <span style={{ fontSize: 12, color: 'var(--color-caption)' }}>/day</span>
              </div>
              <button style={{
                padding: '8px 20px', borderRadius: 8, background: 'var(--color-primary-light)',
                color: 'var(--color-primary-dark)', fontSize: 13, fontWeight: 700, border: 'none', cursor: 'pointer',
              }}>Apply</button>
            </div>
          </div>
          
          {/* Card 3 */}
          <div className="card-shadow tap-feedback" style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '16px', border: '1px solid var(--color-border)',
          }}>
            <div style={{ display: 'flex', gap: 12 }}>
              <div style={{
                width: 48, height: 48, borderRadius: 12, background: 'var(--color-bg)',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24, flexShrink: 0,
              }}>🚚</div>
              <div style={{ flex: 1 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                  <div>
                    <div style={{ fontSize: 16, fontWeight: 700, color: 'var(--color-text)' }}>Delivery Partner</div>
                    <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 2 }}>QuickMart Grocery</div>
                  </div>
                </div>
                <div style={{ display: 'flex', gap: 6, marginTop: 8, flexWrap: 'wrap' }}>
                  <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '4px 8px', borderRadius: 6, fontSize: 12, fontWeight: 500 }}>Flexible</span>
                  <span style={{ background: 'var(--color-bg)', color: 'var(--color-text-secondary)', padding: '4px 8px', borderRadius: 6, fontSize: 12, fontWeight: 500 }}>Kankanady</span>
                </div>
              </div>
            </div>
            
            <div style={{
              display: 'flex', justifyContent: 'space-between', alignItems: 'center',
              marginTop: 16, paddingTop: 16, borderTop: '1px solid var(--color-border)',
            }}>
              <div>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>₹600</span>
                <span style={{ fontSize: 12, color: 'var(--color-caption)' }}>/day</span>
              </div>
              <button style={{
                padding: '8px 20px', borderRadius: 8, background: 'var(--color-primary-light)',
                color: 'var(--color-primary-dark)', fontSize: 13, fontWeight: 700, border: 'none', cursor: 'pointer',
              }}>Apply</button>
            </div>
          </div>
        </div>
      </div>

      <WorkerNav active="home" />
    </div>
  )
}
