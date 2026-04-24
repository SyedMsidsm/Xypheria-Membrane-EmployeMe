import { Bell, ChevronRight, Store, Plus, Users, Star, BarChart3, Clock, Flame } from 'lucide-react'
import { EmployerNav } from '../components/BottomNav'

export default function EmployerDashboard() {
  return (
    <div className="mobile-frame-inner fade-in" style={{ background: 'var(--color-bg)', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 72 }}>
        {/* Header */}
        <div style={{
          background: 'var(--color-navy)',
          padding: '24px 20px 32px',
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <span style={{ fontSize: 16, fontWeight: 700, color: 'white' }}>Good morning, Ganesh!</span>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <Bell size={20} color="rgba(255,255,255,0.8)" />
              <div style={{
                width: 36, height: 36, borderRadius: '50%', background: 'var(--color-primary)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 14, fontWeight: 800, color: 'white',
              }}>G</div>
            </div>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginTop: 16 }}>
            <div style={{
              width: 48, height: 48, borderRadius: '50%', background: 'rgba(255,255,255,0.1)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <Store size={24} color="white" />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 18, fontWeight: 800, color: 'white' }}>Sri Ganesh Provision Store</div>
              <span style={{
                background: 'var(--color-primary)', color: 'white', fontSize: 11, fontWeight: 700,
                padding: '4px 10px', borderRadius: 8, marginTop: 6, display: 'inline-block',
              }}>Verified Business</span>
            </div>
          </div>
          <div style={{ display: 'flex', gap: 8, marginTop: 20 }}>
            {['3 Active Posts', '47 Applicants', '2 Hired'].map(s => (
              <span key={s} style={{
                background: 'rgba(255,255,255,0.1)', color: 'white', padding: '6px 12px',
                borderRadius: 20, fontSize: 12, fontWeight: 600,
              }}>{s}</span>
            ))}
          </div>
        </div>

        {/* Post Job CTA */}
        <div style={{ padding: '0 20px', marginTop: -20 }}>
          <div className="card-shadow tap-feedback" style={{
            background: 'var(--color-primary)',
            borderRadius: 16, padding: '20px', display: 'flex', alignItems: 'center', gap: 16,
            cursor: 'pointer',
          }}>
            <div style={{
              width: 48, height: 48, borderRadius: '50%', background: 'rgba(255,255,255,0.2)',
              display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
            }}>
              <Plus size={24} color="white" />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 16, fontWeight: 800, color: 'white' }}>Find workers now</div>
              <div style={{ fontSize: 13, color: 'rgba(255,255,255,0.8)', marginTop: 4 }}>Post a job in 90 seconds!</div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
              <span style={{ background: 'rgba(255,255,255,0.2)', color: 'white', fontSize: 11, fontWeight: 800, padding: '4px 10px', borderRadius: 12 }}>FREE</span>
              <ChevronRight size={20} color="white" />
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <div style={{ padding: '24px 20px 0', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
          {[
            { icon: <Plus size={24} color="white" />, label: 'Post New Job', bg: 'var(--color-primary)' },
            { icon: <Users size={24} color="white" />, label: 'Applicants', bg: 'var(--color-navy-lighter)' },
            { icon: <Star size={24} color="var(--color-navy)" />, label: 'Reviews', bg: 'var(--color-card)', color: 'var(--color-navy)', border: '1px solid var(--color-border)' },
            { icon: <BarChart3 size={24} color="var(--color-navy)" />, label: 'Analytics', bg: 'var(--color-card)', color: 'var(--color-navy)', border: '1px solid var(--color-border)' },
          ].map(a => (
            <button key={a.label} className="tap-feedback card-shadow" style={{
              height: 88, borderRadius: 16, background: a.bg,
              border: a.border || 'none', cursor: 'pointer', display: 'flex',
              flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 8,
            }}>
              {a.icon}
              <span style={{ fontSize: 14, fontWeight: 700, color: a.color || 'white' }}>{a.label}</span>
            </button>
          ))}
        </div>

        {/* Active Jobs */}
        <div style={{ padding: '32px 20px 0' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
            <span style={{ fontSize: 18, fontWeight: 800, color: 'var(--color-text)' }}>Active Postings</span>
            <span className="tap-feedback" style={{ fontSize: 13, color: 'var(--color-primary)', fontWeight: 600, cursor: 'pointer' }}>View All (3)</span>
          </div>

          {/* Job Card 1 */}
          <div className="card-shadow" style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '20px', marginBottom: 12,
            borderLeft: '4px solid var(--color-primary)', borderTop: '1px solid var(--color-border)', borderRight: '1px solid var(--color-border)', borderBottom: '1px solid var(--color-border)'
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
              <div>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Shop Assistant</span>
                <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 6 }}>
                  <Clock size={14} color="var(--color-alert)" />
                  <span style={{ fontSize: 12, color: 'var(--color-alert)', fontWeight: 600 }}>Expires in 3 days</span>
                </div>
              </div>
              <span style={{ background: 'var(--color-primary-light)', color: 'var(--color-primary-dark)', fontSize: 11, fontWeight: 800, padding: '4px 10px', borderRadius: 12 }}>ACTIVE</span>
            </div>
            
            <div style={{ display: 'flex', gap: 12, marginTop: 16, background: 'var(--color-bg)', padding: '12px', borderRadius: 12 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <Users size={16} color="var(--color-primary)" />
                <span style={{ fontSize: 13, color: 'var(--color-text)', fontWeight: 700 }}>47 applicants</span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <Flame size={16} color="var(--color-alert)" />
                <span style={{ fontSize: 13, color: 'var(--color-alert)', fontWeight: 700 }}>High Interest</span>
              </div>
            </div>
            
            <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
              <button className="tap-feedback" style={{
                flex: 1, height: 44, borderRadius: 12, background: 'var(--color-card)',
                border: '1px solid var(--color-border)', color: 'var(--color-text)', fontSize: 13, fontWeight: 700, cursor: 'pointer',
              }}>View Applicants (47)</button>
              <button className="tap-feedback" style={{
                padding: '0 20px', height: 44, borderRadius: 12, background: 'var(--color-primary)',
                color: 'white', fontSize: 13, fontWeight: 800, border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6
              }}>Boost <Flame size={14} /></button>
            </div>
          </div>

          {/* Job Card 2 */}
          <div className="card-shadow" style={{
            background: 'var(--color-card)', borderRadius: 16, padding: '20px',
            borderLeft: '4px solid var(--color-primary)', borderTop: '1px solid var(--color-border)', borderRight: '1px solid var(--color-border)', borderBottom: '1px solid var(--color-border)'
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
              <div>
                <span style={{ fontSize: 16, fontWeight: 800, color: 'var(--color-text)' }}>Delivery Partner</span>
                <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 6 }}>
                  <Clock size={14} color="var(--color-text-secondary)" />
                  <span style={{ fontSize: 12, color: 'var(--color-text-secondary)', fontWeight: 500 }}>Expires in 7 days</span>
                </div>
              </div>
              <span style={{ background: 'var(--color-primary-light)', color: 'var(--color-primary-dark)', fontSize: 11, fontWeight: 800, padding: '4px 10px', borderRadius: 12 }}>ACTIVE</span>
            </div>
            
            <div style={{ display: 'flex', gap: 12, marginTop: 16, background: 'var(--color-bg)', padding: '12px', borderRadius: 12 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <Users size={16} color="var(--color-primary)" />
                <span style={{ fontSize: 13, color: 'var(--color-text)', fontWeight: 700 }}>12 applicants</span>
              </div>
            </div>
            
            <div style={{ display: 'flex', gap: 8, marginTop: 16 }}>
              <button className="tap-feedback" style={{
                flex: 1, height: 44, borderRadius: 12, background: 'var(--color-card)',
                border: '1px solid var(--color-border)', color: 'var(--color-text)', fontSize: 13, fontWeight: 700, cursor: 'pointer',
              }}>View Applicants (12)</button>
              <button className="tap-feedback" style={{
                padding: '0 20px', height: 44, borderRadius: 12, background: 'var(--color-primary)',
                color: 'white', fontSize: 13, fontWeight: 800, border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6
              }}>Boost <Flame size={14} /></button>
            </div>
          </div>
        </div>

        {/* Recent Applicants */}
        <div style={{ padding: '32px 20px 24px' }}>
          <span style={{ fontSize: 18, fontWeight: 800, color: 'var(--color-text)', display: 'block', marginBottom: 16 }}>Recent Applicants</span>
          <div className="card-shadow" style={{ background: 'var(--color-card)', borderRadius: 16, border: '1px solid var(--color-border)', overflow: 'hidden' }}>
            {[
              { name: 'Raju K.', skills: 'Shop • Clean', dist: '6 min' },
              { name: 'Suresh M.', skills: 'Delivery', dist: '12 min' },
              { name: 'Priya D.', skills: 'Cook • Shop', dist: '8 min' },
            ].map((a, i) => (
              <div key={a.name} className="tap-feedback" style={{
                display: 'flex', alignItems: 'center', gap: 16, padding: '16px',
                borderBottom: i !== 2 ? '1px solid var(--color-border)' : 'none', cursor: 'pointer'
              }}>
                <div style={{
                  width: 44, height: 44, borderRadius: '50%', background: 'var(--color-primary-light)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: 16, fontWeight: 800, color: 'var(--color-primary-dark)', flexShrink: 0
                }}>{a.name[0]}</div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--color-text)' }}>{a.name}</div>
                  <div style={{ fontSize: 13, color: 'var(--color-text-secondary)', marginTop: 2 }}>{a.skills}</div>
                </div>
                <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: 6 }}>
                  <span style={{ fontSize: 12, color: 'var(--color-primary)', fontWeight: 600 }}>🚶 {a.dist}</span>
                  <button style={{
                    padding: '6px 16px', borderRadius: 8, background: 'var(--color-bg)',
                    border: '1px solid var(--color-border)', color: 'var(--color-text)', fontSize: 12, fontWeight: 700, cursor: 'pointer',
                  }}>View</button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <EmployerNav active="home" />
    </div>
  )
}
