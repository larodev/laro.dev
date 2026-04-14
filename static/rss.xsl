<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title><xsl:value-of select="/rss/channel/title"/> - RSS Feed</title>
        <style>
          :root {
            --primary: #2563eb;
            --primary-dark: #1e40af;
            --bg: #ffffff;
            --surface: #f8fafc;
            --border: #e2e8f0;
            --text: #0f172a;
            --text-secondary: #64748b;
            --shadow: rgba(0, 0, 0, 0.1);
          }
          
          @media (prefers-color-scheme: dark) {
            :root {
              --primary: #3b82f6;
              --primary-dark: #60a5fa;
              --bg: #0f172a;
              --surface: #1e293b;
              --border: #334155;
              --text: #f1f5f9;
              --text-secondary: #94a3b8;
              --shadow: rgba(0, 0, 0, 0.3);
            }
          }
          
          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }
          
          body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
            line-height: 1.6;
            padding: 2rem 1rem;
          }
          
          .container {
            max-width: 800px;
            margin: 0 auto;
          }
          
          .header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 3rem 2rem;
            border-radius: 16px;
            margin-bottom: 3rem;
            box-shadow: 0 10px 40px var(--shadow);
            position: relative;
            overflow: hidden;
          }
          
          .header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
          }
          
          .header-content {
            position: relative;
            z-index: 1;
          }
          
          .rss-icon {
            width: 48px;
            height: 48px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 24px;
          }
          
          h1 {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
          }
          
          .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.125rem;
            margin-bottom: 1.5rem;
          }
          
          .subscribe-info {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: 1rem 1.5rem;
            border-radius: 8px;
            color: white;
            font-size: 0.875rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
          }
          
          .subscribe-info strong {
            font-weight: 600;
          }
          
          .feed-url {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
            padding: 0.75rem 1rem;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 8px;
            font-family: 'SF Mono', Monaco, 'Courier New', monospace;
            font-size: 0.875rem;
            color: var(--text);
          }
          
          .feed-url code {
            flex: 1;
            overflow: auto;
            color: var(--primary);
          }
          
          .copy-btn {
            padding: 0.375rem 0.75rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.75rem;
            font-weight: 500;
            transition: background 0.2s;
          }
          
          .copy-btn:hover {
            background: var(--primary-dark);
          }
          
          .stats {
            display: flex;
            gap: 2rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
          }
          
          .stat {
            color: rgba(255, 255, 255, 0.9);
          }
          
          .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
          }
          
          .stat-label {
            font-size: 0.875rem;
            opacity: 0.8;
          }
          
          .items {
            display: grid;
            gap: 1.5rem;
          }
          
          .item {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
          }
          
          .item:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px var(--shadow);
            border-color: var(--primary);
          }
          
          .item-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            gap: 1rem;
            margin-bottom: 0.75rem;
          }
          
          .item-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text);
            line-height: 1.4;
            flex: 1;
          }
          
          .item-date {
            color: var(--text-secondary);
            font-size: 0.875rem;
            white-space: nowrap;
            padding: 0.25rem 0.75rem;
            background: var(--bg);
            border-radius: 6px;
          }
          
          .item-description {
            color: var(--text-secondary);
            line-height: 1.6;
            margin-top: 0.5rem;
          }
          
          .item-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary);
            font-weight: 500;
            font-size: 0.875rem;
            margin-top: 1rem;
          }
          
          .item-link::after {
            content: '→';
            transition: transform 0.2s;
          }
          
          .item:hover .item-link::after {
            transform: translateX(4px);
          }
          
          .footer {
            text-align: center;
            margin-top: 4rem;
            padding-top: 2rem;
            border-top: 1px solid var(--border);
            color: var(--text-secondary);
            font-size: 0.875rem;
          }
          
          @media (max-width: 640px) {
            h1 {
              font-size: 2rem;
            }
            
            .header {
              padding: 2rem 1.5rem;
            }
            
            .stats {
              flex-direction: column;
              gap: 1rem;
            }
            
            .item-header {
              flex-direction: column;
            }
            
            .item-date {
              align-self: flex-start;
            }
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <div class="header-content">
              <div class="rss-icon">🌊</div>
              <h1><xsl:value-of select="/rss/channel/title"/></h1>
              <p class="subtitle">
                <xsl:value-of select="/rss/channel/description"/>
              </p>
              
              <div class="subscribe-info">
                <strong>📡 Feed RSS</strong>
              </div>
              
              <div class="feed-url">
                <code id="feedUrl"><xsl:value-of select="/rss/channel/atom:link/@href"/></code>
                <button class="copy-btn" onclick="copyFeedUrl()">Copy</button>
              </div>
              
              <div class="stats">
                <div class="stat">
                  <div class="stat-value"><xsl:value-of select="count(/rss/channel/item)"/></div>
                  <div class="stat-label">Entradas</div>
                </div>
                <div class="stat">
                  <div class="stat-value">RSS 2.0</div>
                  <div class="stat-label">Formato</div>
                </div>
              </div>
            </div>
          </div>
          
          <div class="items">
            <xsl:for-each select="/rss/channel/item">
              <a class="item" href="{link}">
                <div class="item-header">
                  <h2 class="item-title">
                    <xsl:value-of select="title"/>
                  </h2>
                  <div class="item-date">
                    <xsl:value-of select="substring(pubDate, 1, 16)"/>
                  </div>
                </div>
                <p class="item-description">
                  <xsl:value-of select="description"/>
                </p>
                <span class="item-link">Read more</span>
              </a>
            </xsl:for-each>
          </div>
          
          <div class="footer">
            <p>Generated by Hugo • Styled RSS Feed</p>
          </div>
        </div>
        
        <script>
          function copyFeedUrl() {
            const url = document.getElementById('feedUrl').textContent;
            navigator.clipboard.writeText(url).then(() => {
              const btn = event.target;
              const originalText = btn.textContent;
              btn.textContent = 'Copied!';
              setTimeout(() => {
                btn.textContent = originalText;
              }, 2000);
            });
          }
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
