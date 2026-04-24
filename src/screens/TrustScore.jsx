import { ArrowLeft } from 'lucide-react'

export default function TrustScore() {
  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 20 }}>
        {/* Header */}
        <div style={{ background: 'white', padding: '16px 20px', borderBottom: '1px solid #E2E8F0' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <button style={{ background: 'none', border: 'none', cursor: 'pointer', padding: 8, marginLeft: -8 }}>
              <ArrowLeft size={22} color="#0F172A" />
            </button>
            <div style={{ flex: 1, textAlign: 'center' }}>
              <div style={{ fontSize: 20, fontWeight: 700, color: '#0F172A' }}>Trust Score</div>
              <div style={{ fontSize: 13, color: '#64748B' }}>ನಂಬಿಕೆ ಅಂಕ</div>
            </div>
            <div style={{ width: 38 }} />
          </div>
        </div>

        {/* Score Hero */}
        <div style={{ textAlign: 'center', padding: '24px 20px' }}>
          <div style={{ position: 'relative', width: 160, height: 160, margin: '0 auto' }}>
            <svg width="160" height="160" viewBox="0 0 160 160">
              <circle cx="80" cy="80" r="70" fill="none" stroke="#E2E8F0" strokeWidth="8" />
              <circle cx="80" cy="80" r="70" fill="none" stroke="#22C55E" strokeWidth="8"
                strokeDasharray={`${87 * 4.4} ${(100 - 87) * 4.4}`}
                strokeDashoffset="110" strokeLinecap="round"
                style={{ transition: 'stroke-dasharray 1s ease' }} />
            </svg>
            <div style={{
              position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center',
            }}>
              <span style={{ fontSize: 48, fontWeight: 800, color: '#0F172A' }}>87</span>
              <span style={{ fontSize: 16, color: '#64748B' }}>/100</span>
              <span style={{ fontSize: 14, fontWeight: 600, color: '#22C55E', marginTop: 2 }}>Good Standing</span>
            </div>
          </div>
          <p style={{ fontSize: 14, color: '#64748B', marginTop: 12 }}>Better score = More job offers</p>
        </div>

        {/* Score Breakdown */}
        <div style={{ padding: '0 20px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 600, color: '#0F172A', marginBottom: 12 }}>How is your score calculated?</h3>

          {[
            { icon: '✅', title: 'Phone Verified', desc: 'Your number confirmed via OTP', points: '+25', status: 'done' },
            { icon: '✅', title: 'Profile Completed', desc: 'Photo, name, skills added', points: '+20', status: 'done' },
            { icon: '✅', title: 'Community Verified', desc: 'Verified by 2 neighbors in your area', points: '+20', status: 'done', link: 'How this works →' },
            { icon: '✅', title: 'First Job Done', desc: 'Successfully completed first job', points: '+15', status: 'done' },
            { icon: '⏳', title: 'NGO Ground Verification', desc: 'A local NGO partner will verify your identity', points: '+10', status: 'pending' },
            { icon: '⭐', title: 'Employer Reviews', desc: 'You have 4.8 avg rating', points: '7/10', status: 'partial' },
          ].map((f, i) => (
            <div key={i} style={{
              background: 'white', borderRadius: 12, padding: '14px 16px', marginBottom: 8,
              boxShadow: '0 1px 4px rgba(0,0,0,0.04)', display: 'flex', alignItems: 'center', gap: 12,
            }}>
              <div style={{
                width: 40, height: 40, borderRadius: '50%',
                background: f.status === 'done' ? '#F0FDF4' : f.status === 'pending' ? '#FFF7ED' : '#FFFBEB',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 18, flexShrink: 0,
              }}>{f.icon}</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 15, fontWeight: 700, color: '#0F172A' }}>{f.title}</div>
                <div style={{ fontSize: 13, color: '#64748B', marginTop: 2 }}>{f.desc}</div>
                {f.link && <span style={{ fontSize: 12, color: '#64748B', cursor: 'pointer' }}>{f.link}</span>}
                {f.status === 'pending' && (
                  <button style={{
                    marginTop: 8, padding: '6px 12px', borderRadius: 8, background: '#F97316',
                    color: 'white', fontSize: 12, fontWeight: 700, border: 'none', cursor: 'pointer',
                  }}>REQUEST VERIFICATION</button>
                )}
                {f.status === 'partial' && (
                  <div style={{ marginTop: 6, height: 4, borderRadius: 2, background: '#E2E8F0', width: '100%' }}>
                    <div style={{ width: '70%', height: '100%', borderRadius: 2, background: '#D97706' }} />
                  </div>
                )}
              </div>
              <span style={{
                fontSize: 14, fontWeight: 700,
                color: f.status === 'done' ? '#22C55E' : f.status === 'pending' ? '#F97316' : '#64748B',
              }}>{f.points}</span>
            </div>
          ))}
        </div>

        {/* How to Improve */}
        <div style={{ padding: '16px 20px' }}>
          <h3 style={{ fontSize: 16, fontWeight: 600, color: '#22C55E', marginBottom: 12 }}>Increase your score</h3>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
            <button style={{
              padding: '12px 16px', borderRadius: 12, background: '#FFF7ED', border: '1px solid #F97316',
              textAlign: 'left', cursor: 'pointer', fontSize: 14, color: '#F97316', fontWeight: 600,
            }}>→ Get NGO Verified (+10 pts)</button>
            <span style={{ fontSize: 14, color: '#3B82F6', fontWeight: 600, cursor: 'pointer', paddingLeft: 4 }}>→ Complete 5 more jobs (+5 pts)</span>
            <span style={{ fontSize: 14, color: '#22C55E', fontWeight: 600, cursor: 'pointer', paddingLeft: 4 }}>→ Get 3 more reviews (+3 pts)</span>
          </div>
        </div>
      </div>
    </div>
  )
}
