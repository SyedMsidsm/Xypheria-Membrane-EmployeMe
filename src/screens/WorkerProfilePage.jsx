import { Edit2, Share2, Star } from 'lucide-react'
import { WorkerNav } from '../components/BottomNav'

export default function WorkerProfilePage() {
  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 72 }}>
        {/* Profile Header */}
        <div style={{
          background: 'linear-gradient(135deg, #1E3A5F, #2D5986)',
          padding: '24px 20px 40px', position: 'relative',
        }}>
          <button style={{
            position: 'absolute', top: 16, right: 16, background: 'rgba(255,255,255,0.15)',
            border: 'none', borderRadius: '50%', width: 36, height: 36, cursor: 'pointer',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>
            <Edit2 size={16} color="white" />
          </button>
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
            <div style={{ position: 'relative' }}>
              <div style={{
                width: 88, height: 88, borderRadius: '50%', background: '#22C55E',
                border: '3px solid white', display: 'flex', alignItems: 'center',
                justifyContent: 'center', fontSize: 36, fontWeight: 700, color: 'white',
              }}>R</div>
              <div style={{
                position: 'absolute', bottom: 4, right: 4, width: 16, height: 16,
                borderRadius: '50%', background: '#22C55E', border: '3px solid #2D5986',
              }} />
            </div>
            <div style={{
              background: '#22C55E', borderRadius: 12, padding: '4px 12px', marginTop: 8,
              fontSize: 11, fontWeight: 600, color: 'white',
            }}>Available Now</div>
            <h2 style={{ fontSize: 22, fontWeight: 700, color: 'white', marginTop: 8 }}>Raju Kumar</h2>
            <p style={{ fontSize: 14, color: 'rgba(255,255,255,0.7)', marginTop: 2 }}>📍 Kodialbail, Mangalore</p>
            <p style={{ fontSize: 12, color: 'rgba(255,255,255,0.5)', marginTop: 2 }}>Member since April 2025</p>
          </div>
        </div>

        {/* Trust Score Card */}
        <div style={{
          margin: '-20px 20px 0', background: 'white', borderRadius: 16,
          padding: '16px', boxShadow: '0 4px 20px rgba(0,0,0,0.1)',
          position: 'relative', zIndex: 10,
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
            <span style={{ fontSize: 16, fontWeight: 600, color: '#0F172A' }}>Trust Score 🛡️</span>
            <span style={{ fontSize: 12, color: '#22C55E', fontWeight: 600, cursor: 'pointer' }}>What is this?</span>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 20 }}>
            {/* Circular gauge */}
            <div style={{ position: 'relative', width: 80, height: 80, flexShrink: 0 }}>
              <svg width="80" height="80" viewBox="0 0 80 80">
                <circle cx="40" cy="40" r="34" fill="none" stroke="#E2E8F0" strokeWidth="6" />
                <circle cx="40" cy="40" r="34" fill="none" stroke="#22C55E" strokeWidth="6"
                  strokeDasharray={`${87 * 2.14} ${(100 - 87) * 2.14}`}
                  strokeDashoffset="53.5" strokeLinecap="round" />
              </svg>
              <div style={{
                position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column',
                alignItems: 'center', justifyContent: 'center',
              }}>
                <span style={{ fontSize: 24, fontWeight: 800, color: '#0F172A' }}>87</span>
                <span style={{ fontSize: 10, color: '#64748B' }}>/100</span>
              </div>
            </div>
            <div style={{ flex: 1 }}>
              <span style={{ fontSize: 14, fontWeight: 700, color: '#22C55E' }}>Good</span>
              <div style={{ marginTop: 8, fontSize: 12, display: 'flex', flexDirection: 'column', gap: 4 }}>
                <span style={{ color: '#22C55E' }}>✅ Phone Verified</span>
                <span style={{ color: '#22C55E' }}>✅ Community Verified</span>
                <span style={{ color: '#F97316', cursor: 'pointer' }}>⏳ NGO Verified — Get verified →</span>
              </div>
            </div>
          </div>
        </div>

        {/* Stats Row */}
        <div style={{ display: 'flex', gap: 8, margin: '16px 20px 0' }}>
          {[
            { num: '12', label: 'Jobs Done' },
            { num: '₹18,400', label: 'Earned' },
            { num: '100%', label: 'Show-up' },
          ].map(s => (
            <div key={s.label} style={{
              flex: 1, background: 'white', borderRadius: 12, padding: '12px 8px',
              textAlign: 'center', boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
            }}>
              <div style={{ fontSize: 18, fontWeight: 800, color: '#22C55E' }}>{s.num}</div>
              <div style={{ fontSize: 11, color: '#64748B', marginTop: 2 }}>{s.label}</div>
            </div>
          ))}
        </div>

        {/* Skills */}
        <div style={{ padding: '16px 20px 0' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 10 }}>
            <span style={{ fontSize: 16, fontWeight: 600, color: '#0F172A' }}>My Skills / ನನ್ನ ಕೌಶಲ್ಯಗಳು</span>
            <span style={{ fontSize: 13, color: '#22C55E', fontWeight: 600, cursor: 'pointer' }}>Edit</span>
          </div>
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
            {['🍳 Cooking', '🧹 Cleaning', '🚚 Delivery', '🏪 Shop Helper'].map(s => (
              <span key={s} style={{
                background: '#F0FDF4', color: '#22C55E', padding: '8px 14px',
                borderRadius: 20, fontSize: 13, fontWeight: 600,
              }}>{s}</span>
            ))}
            <span style={{ fontSize: 13, color: '#64748B', padding: '8px 4px' }}>+ 2 more</span>
          </div>
        </div>

        {/* Availability */}
        <div style={{ margin: '16px 20px 0', background: 'white', borderRadius: 16, padding: '16px', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
          <span style={{ fontSize: 16, fontWeight: 600, color: '#0F172A' }}>My Availability / ಲಭ್ಯತೆ</span>
          <div style={{ display: 'flex', gap: 6, marginTop: 10 }}>
            {['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((d, i) => (
              <div key={d} style={{
                width: 36, height: 36, borderRadius: '50%',
                background: i < 5 ? '#22C55E' : '#E2E8F0',
                color: i < 5 ? 'white' : '#94A3B8',
                fontSize: 10, fontWeight: 700, display: 'flex', alignItems: 'center',
                justifyContent: 'center',
              }}>{d}</div>
            ))}
          </div>
          <div style={{ display: 'flex', gap: 8, marginTop: 10 }}>
            <span style={{ background: '#F0FDF4', color: '#22C55E', padding: '4px 12px', borderRadius: 12, fontSize: 12, fontWeight: 600 }}>🌅 Morning</span>
            <span style={{ fontSize: 12, color: '#64748B', padding: '4px 0' }}>Available: Immediately</span>
          </div>
        </div>

        {/* Reviews */}
        <div style={{ padding: '16px 20px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
            <span style={{ fontSize: 16, fontWeight: 600, color: '#0F172A' }}>Work History ⭐ 4.8 <span style={{ color: '#94A3B8', fontWeight: 400, fontSize: 13 }}>(12 reviews)</span></span>
          </div>

          {/* Review 1 */}
          <div style={{
            background: 'white', borderRadius: 16, padding: '14px',
            boxShadow: '0 1px 4px rgba(0,0,0,0.04)', marginBottom: 10,
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                <div style={{
                  width: 36, height: 36, borderRadius: '50%', background: '#F0FDF4',
                  display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 14,
                }}>🏪</div>
                <span style={{ fontSize: 14, fontWeight: 700, color: '#0F172A' }}>Sri Ganesh Store</span>
              </div>
              <span style={{ fontSize: 12, color: '#94A3B8' }}>Aug 2025</span>
            </div>
            <div style={{ marginTop: 6, fontSize: 14, color: '#D97706' }}>⭐⭐⭐⭐⭐</div>
            <p style={{ fontSize: 13, color: '#64748B', marginTop: 6, lineHeight: 1.5 }}>
              Excellent worker, very punctual and honest
            </p>
            <div style={{ display: 'flex', gap: 6, marginTop: 8 }}>
              {['✅ On Time', '✅ Honest', '✅ Hardworking'].map(b => (
                <span key={b} style={{
                  background: '#F0FDF4', color: '#22C55E', padding: '3px 8px',
                  borderRadius: 8, fontSize: 10, fontWeight: 600,
                }}>{b}</span>
              ))}
            </div>
          </div>

          {/* Review 2 */}
          <div style={{
            background: 'white', borderRadius: 16, padding: '14px',
            boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                <div style={{
                  width: 36, height: 36, borderRadius: '50%', background: '#EFF6FF',
                  display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 14,
                }}>🍳</div>
                <span style={{ fontSize: 14, fontWeight: 700, color: '#0F172A' }}>Hotel Udupi</span>
              </div>
              <span style={{ fontSize: 12, color: '#94A3B8' }}>Jul 2025</span>
            </div>
            <div style={{ marginTop: 6, fontSize: 14, color: '#D97706' }}>⭐⭐⭐⭐</div>
            <p style={{ fontSize: 13, color: '#64748B', marginTop: 6, lineHeight: 1.5 }}>
              Good worker, reliable and quick to learn
            </p>
            <div style={{ display: 'flex', gap: 6, marginTop: 8 }}>
              {['✅ Reliable', '✅ Would Rehire'].map(b => (
                <span key={b} style={{
                  background: '#F0FDF4', color: '#22C55E', padding: '3px 8px',
                  borderRadius: 8, fontSize: 10, fontWeight: 600,
                }}>{b}</span>
              ))}
            </div>
          </div>

          <p style={{ textAlign: 'center', fontSize: 13, color: '#22C55E', fontWeight: 600, marginTop: 12, cursor: 'pointer' }}>
            View all 12 reviews
          </p>
        </div>

        {/* Bottom Actions */}
        <div style={{ padding: '0 20px 16px', display: 'flex', gap: 10 }}>
          <button style={{
            flex: 1, height: 48, borderRadius: 12, background: 'white',
            border: '1.5px solid #E2E8F0', color: '#0F172A', fontWeight: 600,
            fontSize: 14, cursor: 'pointer',
          }}>📤 Share Profile</button>
          <button style={{
            flex: 1, height: 48, borderRadius: 12, background: '#22C55E',
            color: 'white', fontWeight: 700, fontSize: 14, border: 'none', cursor: 'pointer',
          }}>✏️ Edit Profile</button>
        </div>
      </div>

      <WorkerNav active="profile" />
    </div>
  )
}
