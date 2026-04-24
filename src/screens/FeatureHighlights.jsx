export default function FeatureHighlights() {
  return (
    <div className="mobile-frame-inner" style={{ background: '#F8FAFC', display: 'flex', flexDirection: 'column', height: '100%' }}>
      <div style={{ flex: 1, overflow: 'auto', paddingBottom: 20 }}>
        {/* Header */}
        <div style={{ padding: '20px 20px 0', textAlign: 'center' }}>
          <h1 style={{ fontSize: 24, fontWeight: 700, color: '#0F172A' }}>What Makes Us Different</h1>
          <p style={{ fontSize: 13, color: '#64748B', marginTop: 4 }}>ನಮ್ಮನ್ನು ಭಿನ್ನವಾಗಿಸುವುದು ಏನು?</p>
        </div>

        <div style={{ padding: '16px 20px', display: 'flex', flexDirection: 'column', gap: 14 }}>
          {/* Card 1 — Hyperlocal GPS */}
          <div style={{
            background: 'linear-gradient(135deg, #1E3A5F, #2D5986)',
            borderRadius: 16, padding: '20px', overflow: 'hidden', position: 'relative',
          }}>
            {/* Map illustration */}
            <div style={{ textAlign: 'center', marginBottom: 12 }}>
              <svg width="200" height="80" viewBox="0 0 200 80">
                <circle cx="100" cy="40" r="15" fill="none" stroke="rgba(34,197,94,0.4)" strokeWidth="1" />
                <circle cx="100" cy="40" r="30" fill="none" stroke="rgba(34,197,94,0.25)" strokeWidth="1" />
                <circle cx="100" cy="40" r="38" fill="none" stroke="rgba(34,197,94,0.15)" strokeWidth="1" strokeDasharray="4 4" />
                <circle cx="100" cy="40" r="6" fill="#22C55E" />
                <circle cx="100" cy="40" r="3" fill="white" />
                <text x="118" y="20" fill="rgba(255,255,255,0.5)" fontSize="8">500m</text>
                <text x="135" y="35" fill="rgba(255,255,255,0.4)" fontSize="8">2km</text>
                <text x="142" y="55" fill="rgba(255,255,255,0.3)" fontSize="8">5km</text>
                {/* Job pins */}
                <circle cx="85" cy="30" r="4" fill="#22C55E" opacity="0.8" />
                <circle cx="110" cy="50" r="4" fill="#22C55E" opacity="0.8" />
                <circle cx="120" cy="28" r="3" fill="#22C55E" opacity="0.6" />
              </svg>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6 }}>
              <span style={{ fontSize: 28 }}>📍</span>
              <span style={{ fontSize: 18, fontWeight: 700, color: 'white' }}>Hyperlocal GPS Matching</span>
            </div>
            <p style={{ fontSize: 12, color: 'rgba(255,255,255,0.6)', marginBottom: 10 }}>ಹೈಪರ್ಲೋಕಲ್ GPS ಮ್ಯಾಚಿಂಗ್</p>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
              {['Jobs sorted by walking distance', 'Shows \'8 min walk\' not \'0.6km\'', 'Walk-to-work = ₹100/day saved'].map(b => (
                <span key={b} style={{ fontSize: 13, color: 'rgba(255,255,255,0.85)' }}>✓ {b}</span>
              ))}
            </div>
            <div style={{ marginTop: 12, display: 'flex', justifyContent: 'flex-end' }}>
              <span style={{
                background: 'rgba(34,197,94,0.2)', color: '#22C55E', padding: '4px 12px',
                borderRadius: 12, fontSize: 12, fontWeight: 600,
              }}>3-4x higher conversion ↗</span>
            </div>
          </div>

          {/* Card 2 — No Resume */}
          <div style={{
            background: 'linear-gradient(135deg, #22C55E, #16A34A)',
            borderRadius: 16, padding: '20px',
          }}>
            <div style={{
              display: 'flex', justifyContent: 'center', gap: 16, marginBottom: 12, alignItems: 'center',
            }}>
              <div style={{ textAlign: 'center' }}>
                <div style={{ fontSize: 14, color: 'rgba(255,255,255,0.7)', marginBottom: 4 }}>Traditional</div>
                <div style={{ fontSize: 28, textDecoration: 'line-through', opacity: 0.6 }}>📄</div>
                <div style={{ fontSize: 10, color: 'rgba(255,255,255,0.5)' }}>CV Required</div>
              </div>
              <span style={{ fontSize: 20, color: 'white' }}>→</span>
              <div style={{ textAlign: 'center' }}>
                <div style={{ fontSize: 14, color: 'white', marginBottom: 4, fontWeight: 600 }}>EmployMe</div>
                <div style={{ fontSize: 28 }}>🏪</div>
                <div style={{ fontSize: 10, color: 'rgba(255,255,255,0.8)' }}>Just tap skills!</div>
              </div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6 }}>
              <span style={{ fontSize: 28 }}>👤</span>
              <span style={{ fontSize: 18, fontWeight: 700, color: 'white' }}>Zero-Resume Onboarding</span>
            </div>
            <p style={{ fontSize: 12, color: 'rgba(255,255,255,0.7)', marginBottom: 10 }}>ರೆಸ್ಯೂಮೆ ಇಲ್ಲದೆ ಅರ್ಜಿ ಸಲ್ಲಿಸಿ</p>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
              {['Select skills with icons only', '2-minute onboarding', 'Opens access to 400M excluded workers'].map(b => (
                <span key={b} style={{ fontSize: 13, color: 'white' }}>✓ {b}</span>
              ))}
            </div>
            <p style={{ fontSize: 12, fontWeight: 700, color: 'white', marginTop: 12 }}>12-18 month head start vs competitors</p>
          </div>

          {/* Card 3 — Dual Trust */}
          <div style={{
            background: '#1E293B', borderRadius: 16, padding: '20px',
          }}>
            <div style={{ textAlign: 'center', marginBottom: 12 }}>
              <svg width="80" height="80" viewBox="0 0 80 80">
                <path d="M40 8 L66 22 L66 44 C66 58 54 70 40 74 C26 70 14 58 14 44 L14 22 Z"
                  fill="none" stroke="#22C55E" strokeWidth="2" />
                <path d="M40 16 L58 26 L58 42 C58 52 50 62 40 66 C30 62 22 52 22 42 L22 26 Z"
                  fill="rgba(34,197,94,0.1)" stroke="rgba(34,197,94,0.4)" strokeWidth="1" />
                <text x="40" y="36" textAnchor="middle" fill="#3B82F6" fontSize="10" fontWeight="700">AI</text>
                <text x="40" y="52" textAnchor="middle" fill="#22C55E" fontSize="10" fontWeight="700">NGO</text>
              </svg>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6 }}>
              <span style={{ fontSize: 28 }}>🛡️</span>
              <span style={{ fontSize: 18, fontWeight: 700, color: 'white' }}>Dual-Layer Verification</span>
            </div>
            <p style={{ fontSize: 12, color: '#94A3B8', marginBottom: 10 }}>ದ್ವಿ-ಸ್ತರ ಪರಿಶೀಲನೆ</p>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <span style={{ fontSize: 13, color: 'rgba(255,255,255,0.85)' }}>Layer 1: Aadhaar + AI fraud detection</span>
                <span style={{ background: '#3B82F6', color: 'white', fontSize: 10, padding: '2px 8px', borderRadius: 6, fontWeight: 700 }}>Auto</span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <span style={{ fontSize: 13, color: 'rgba(255,255,255,0.85)' }}>Layer 2: NGO in-person verification</span>
                <span style={{ background: '#22C55E', color: 'white', fontSize: 10, padding: '2px 8px', borderRadius: 6, fontWeight: 700 }}>Human</span>
              </div>
            </div>
            <p style={{ fontSize: 13, fontWeight: 700, color: '#22C55E', marginTop: 12 }}>Target: 95% trust score</p>
          </div>
        </div>

        {/* Tech Stack */}
        <div style={{ padding: '0 20px 8px' }}>
          <span style={{ fontSize: 12, color: '#94A3B8', fontWeight: 600, display: 'block', marginBottom: 8 }}>Powered By</span>
          <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap' }}>
            {['Flutter', 'Firebase', 'Node.js', 'Twilio', 'Geohashing ML'].map(t => (
              <span key={t} style={{
                background: '#1E293B', color: '#94A3B8', padding: '6px 12px',
                borderRadius: 8, fontSize: 11, fontWeight: 600,
              }}>{t}</span>
            ))}
          </div>
        </div>

        {/* Matching Formula */}
        <div style={{ padding: '8px 20px 16px' }}>
          <div style={{
            background: '#1E293B', borderRadius: 12, padding: '16px',
          }}>
            <span style={{ fontSize: 13, fontWeight: 600, color: '#22C55E', display: 'block', marginBottom: 8 }}>Our Matching Algorithm:</span>
            <div style={{ fontFamily: 'monospace', fontSize: 12, lineHeight: 1.8, color: 'white' }}>
              <span style={{ color: '#94A3B8' }}>Score = </span><br />
              {'  '}<span style={{ color: '#22C55E' }}>Distance</span>    × <span style={{ color: 'white' }}>0.40</span><br />
              + <span style={{ color: '#22C55E' }}>Skill Match</span> × <span style={{ color: 'white' }}>0.30</span><br />
              + <span style={{ color: '#22C55E' }}>Urgency</span>     × <span style={{ color: 'white' }}>0.20</span><br />
              + <span style={{ color: '#22C55E' }}>Trust Score</span> × <span style={{ color: 'white' }}>0.10</span>
            </div>
            <p style={{ fontSize: 11, color: '#94A3B8', marginTop: 8 }}>Sub-100ms response on 3G</p>
          </div>
        </div>
      </div>
    </div>
  )
}
