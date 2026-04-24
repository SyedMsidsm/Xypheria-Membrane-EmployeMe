import { WorkerNav } from '../components/BottomNav'
import { useState } from 'react'

export default function Notifications() {
  const [filter, setFilter] = useState('All')

  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 72 }}>
        {/* Header */}
        <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div>
              <h1 style={{ fontSize: 22, fontWeight: 700, color: '#0F172A' }}>Notifications</h1>
              <p style={{ fontSize: 13, color: '#64748B' }}>ಅಧಿಸೂಚನೆಗಳು</p>
            </div>
            <span style={{ fontSize: 13, color: '#64748B', cursor: 'pointer' }}>Mark all read</span>
          </div>
          <div style={{ display: 'flex', gap: 8, marginTop: 12 }}>
            {['All', 'Jobs', 'Messages', 'System'].map(f => (
              <button key={f} onClick={() => setFilter(f)} style={{
                padding: '6px 14px', borderRadius: 20,
                background: filter === f ? '#22C55E' : 'white',
                color: filter === f ? 'white' : '#64748B',
                border: filter === f ? 'none' : '1.5px solid #E2E8F0',
                fontSize: 12, fontWeight: 600, cursor: 'pointer',
              }}>{f}</button>
            ))}
          </div>
        </div>

        {/* Today */}
        <div style={{ padding: '16px 20px 8px' }}>
          <span style={{ fontSize: 12, fontWeight: 700, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: 1 }}>Today</span>
        </div>

        {/* Notification 1 - Urgent */}
        <div style={{
          margin: '0 20px 10px', background: '#F0FDF4', borderRadius: 16, padding: '14px 16px',
          borderLeft: '4px solid #EF4444',
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#FEF2F2',
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16, flexShrink: 0,
            }}>🔴</div>
            <div style={{ flex: 1 }}>
              <p style={{ fontSize: 14, fontWeight: 700, color: '#EF4444' }}>URGENT JOB NEAR YOU!</p>
              <p style={{ fontSize: 13, color: '#64748B', marginTop: 4, lineHeight: 1.5 }}>
                Sri Ganesh Store needs a Shop Helper within 500m — ₹500/day
              </p>
              <div style={{ display: 'flex', gap: 12, marginTop: 6 }}>
                <span style={{ fontSize: 12, color: '#64748B' }}>⚡ 5 min ago</span>
                <span style={{ fontSize: 12, color: '#22C55E', fontWeight: 600 }}>🚶 6 min walk</span>
              </div>
              <span style={{ fontSize: 13, color: '#22C55E', fontWeight: 600, cursor: 'pointer', marginTop: 4, display: 'inline-block' }}>View Job →</span>
            </div>
          </div>
        </div>

        {/* Notification 2 - Offer */}
        <div style={{
          margin: '0 20px 10px', background: '#F0FDF4', borderRadius: 16, padding: '14px 16px',
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#F0FDF4',
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16, flexShrink: 0,
              border: '2px solid #22C55E',
            }}>✅</div>
            <div style={{ flex: 1 }}>
              <p style={{ fontSize: 14, fontWeight: 700, color: '#22C55E' }}>Job Offer Received! 🎉</p>
              <p style={{ fontSize: 13, color: '#64748B', marginTop: 4, lineHeight: 1.5 }}>
                Hotel Udupi Delights sent you an offer for Kitchen Helper
              </p>
              <span style={{ fontSize: 12, color: '#94A3B8', marginTop: 4, display: 'block' }}>1 hour ago</span>
              <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
                <button style={{ padding: '6px 14px', borderRadius: 10, background: '#22C55E', color: 'white', fontSize: 12, fontWeight: 700, border: 'none', cursor: 'pointer' }}>Accept</button>
                <button style={{ padding: '6px 14px', borderRadius: 10, background: 'white', border: '1px solid #E2E8F0', color: '#64748B', fontSize: 12, fontWeight: 600, cursor: 'pointer' }}>View</button>
              </div>
            </div>
          </div>
        </div>

        {/* Notification 3 - Message */}
        <div style={{
          margin: '0 20px 10px', background: 'white', borderRadius: 16, padding: '14px 16px',
          boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#EFF6FF',
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16, flexShrink: 0,
            }}>💬</div>
            <div style={{ flex: 1 }}>
              <p style={{ fontSize: 14, fontWeight: 700, color: '#0F172A' }}>New message from employer</p>
              <p style={{ fontSize: 13, color: '#64748B', marginTop: 4, lineHeight: 1.5 }}>
                FreshMart: "Can you come for an interview tomorrow?"
              </p>
              <span style={{ fontSize: 12, color: '#94A3B8' }}>3 hours ago</span>
              <span style={{ fontSize: 13, color: '#3B82F6', fontWeight: 600, cursor: 'pointer', display: 'block', marginTop: 4 }}>Reply →</span>
            </div>
          </div>
        </div>

        {/* Yesterday */}
        <div style={{ padding: '16px 20px 8px' }}>
          <span style={{ fontSize: 12, fontWeight: 700, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: 1 }}>Yesterday</span>
        </div>

        {/* Trust Score */}
        <div style={{
          margin: '0 20px 10px', background: 'white', borderRadius: 16, padding: '14px 16px',
          boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#EFF6FF',
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16, flexShrink: 0,
            }}>🛡️</div>
            <div>
              <p style={{ fontSize: 14, fontWeight: 700, color: '#1E3A5F' }}>Trust Score increased!</p>
              <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>Your score went from 82 to 87. Get NGO verified to reach 95+</p>
              <span style={{ fontSize: 12, color: '#94A3B8' }}>Yesterday 2:30 PM</span>
              <span style={{ fontSize: 12, color: '#1E3A5F', fontWeight: 600, display: 'block', marginTop: 4, cursor: 'pointer' }}>Learn more →</span>
            </div>
          </div>
        </div>

        {/* Profile reminder */}
        <div style={{
          margin: '0 20px 10px', background: 'white', borderRadius: 16, padding: '14px 16px',
          boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#FFF7ED',
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16, flexShrink: 0,
            }}>⏰</div>
            <div>
              <p style={{ fontSize: 14, fontWeight: 700, color: '#0F172A' }}>Complete your profile</p>
              <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>Add a photo to get 3x more views</p>
              <span style={{ fontSize: 12, color: '#F97316', fontWeight: 600, cursor: 'pointer', display: 'block', marginTop: 4 }}>Complete now →</span>
            </div>
          </div>
        </div>

        {/* Old notification */}
        <div style={{
          margin: '0 20px 10px', background: 'white', borderRadius: 16, padding: '14px 16px', opacity: 0.6,
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: '50%', background: '#F1F5F9',
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16, flexShrink: 0,
            }}>📋</div>
            <div>
              <p style={{ fontSize: 14, fontWeight: 600, color: '#64748B' }}>New jobs in your area</p>
              <p style={{ fontSize: 13, color: '#94A3B8', marginTop: 4 }}>8 new Delivery jobs near Kodialbail</p>
              <span style={{ fontSize: 12, color: '#94A3B8' }}>2 days ago</span>
            </div>
          </div>
        </div>

        <p style={{ textAlign: 'center', fontSize: 13, color: '#94A3B8', padding: '16px 0' }}>
          You're all caught up! 🎉
        </p>
      </div>

      <WorkerNav active="home" />
    </div>
  )
}
