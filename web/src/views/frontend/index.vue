<template>
    <div class="home-container">
        <Header />

        <!-- 主要功能区块 -->
        <div class="main-features">
            <div class="section-title">
                <h2>全方位支付解决方案</h2>
                <p>基于云原生架构,为您提供安全、稳定、高效的支付服务</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fa fa-credit-card"></i>
                    </div>
                    <h3>聚合支付</h3>
                    <p>支持支付宝、微信支付等多种支付方式,一码集成全渠道</p>
                    <div class="feature-tags">
                        <span>扫码支付</span>
                        <span>H5支付</span>
                        <span>小程序支付</span>
                    </div>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fa fa-random"></i>
                    </div>
                    <h3>智能路由</h3>
                    <p>自动分配最优支付通道,确保支付成功率</p>
                    <div class="feature-tags">
                        <span>通道备份</span>
                        <span>智能切换</span>
                        <span>负载均衡</span>
                    </div>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fa fa-shield"></i>
                    </div>
                    <h3>安全防护</h3>
                    <p>全方位的安全防护措施,保障交易安全</p>
                    <div class="feature-tags">
                        <span>数据加密</span>
                        <span>实时监控</span>
                        <span>风控系统</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 核心优势区块 -->
        <div class="core-advantages">
            <div class="section-title">
                <h2>为什么选择我们</h2>
                <p>稳定、安全、高性能的支付体验</p>
            </div>

            <div class="advantages-grid">
                <div class="advantage-item">
                    <div class="advantage-icon">
                        <i class="fa fa-rocket"></i>
                    </div>
                    <div class="advantage-content">
                        <h3>极速响应</h3>
                        <ul>
                            <li>毫秒级响应速度</li>
                            <li>99.99%系统可用性</li>
                            <li>全球节点部署</li>
                        </ul>
                    </div>
                </div>

                <div class="advantage-item">
                    <div class="advantage-icon">
                        <i class="fa fa-lock"></i>
                    </div>
                    <div class="advantage-content">
                        <h3>安全可靠</h3>
                        <ul>
                            <li>银行级数据加密</li>
                            <li>实时风控监测</li>
                            <li>多重安全防护</li>
                        </ul>
                    </div>
                </div>

                <div class="advantage-item">
                    <div class="advantage-icon">
                        <i class="fa fa-cogs"></i>
                    </div>
                    <div class="advantage-content">
                        <h3>简单易用</h3>
                        <ul>
                            <li>5分钟快速接入</li>
                            <li>完善的开发文档</li>
                            <li>7*24小时技术支持</li>
                        </ul>
                    </div>
                        </div>

                <div class="advantage-item">
                    <div class="advantage-icon">
                        <i class="fa fa-line-chart"></i>
                    </div>
                    <div class="advantage-content">
                        <h3>数据分析</h3>
                        <ul>
                            <li>实时交易统计</li>
                            <li>多维度数据分析</li>
                            <li>自定义报表导出</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- 快速开始区块 -->
        <div class="quick-start">
            <div class="start-content">
                <h2>开始使用</h2>
                <p>只需简单几步,即可享受专业的支付服务</p>
                <div class="action-buttons">
                    <el-button type="primary" size="large" @click="handleAction('doc')">
                        <i class="fa fa-book"></i>
                        开发文档
                    </el-button>
                    <el-button type="success" size="large" @click="handleAction('login')">
                        <i class="fa fa-user"></i>
                        商户登录
                    </el-button>
                </div>
            </div>
        </div>

        <Footer />

        <!-- 联系对话框 -->
        <el-dialog
            v-model="dialogVisible"
            :title="dialogTitle"
            width="360px"
            align-center
            :show-close="false"
            class="contact-dialog"
        >
            <div class="contact-content">
                <i class="fa fa-headphones"></i>
                <div class="contact-text">{{ dialogContent }}</div>
                <div class="contact-info">
                    <div class="info-item">
                        <i class="fa fa-qq"></i>
                        <span>QQ：{{ contactInfo.qq }}</span>
                    </div>
                    <div class="info-item">
                        <i class="fa fa-weixin"></i>
                        <span>微信：{{ contactInfo.wechat }}</span>
                    </div>
                    <div class="info-item">
                        <i class="fa fa-envelope"></i>
                        <span>邮箱：{{ contactInfo.email }}</span>
                    </div>
                </div>
            </div>
            <template #footer>
                <div class="dialog-footer">
                    <el-button @click="dialogVisible = false" type="primary" round>我知道了</el-button>
                </div>
            </template>
        </el-dialog>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useSiteConfig } from '/@/stores/siteConfig'
import { useMemberCenter } from '/@/stores/memberCenter'
import Header from '/@/layouts/frontend/components/header.vue'
import Footer from '/@/layouts/frontend/components/footer.vue'
import { memberCenterBaseRoutePath } from '/@/router/static/memberCenterBase'
import { getContactInfo } from '/@/api/frontend/index'

const siteConfig = useSiteConfig()
const memberCenter = useMemberCenter()

const dialogVisible = ref(false)
const dialogTitle = ref('')
const dialogContent = ref('')
const contactInfo = ref({
    qq: '',
    wechat: '',
    email: ''
})

// 获取联系方式
const fetchContactInfo = async () => {
    try {
        const res = await getContactInfo()
        if (res.code === 1 && res.data.contact) {
            contactInfo.value = res.data.contact
        }
    } catch (error) {
        console.error('获取联系方式失败:', error)
    }
}

onMounted(() => {
    fetchContactInfo()
})

// 处理按钮点击
const handleAction = (type: string) => {
    if (type === 'doc') {
        dialogTitle.value = '开发文档'
        dialogContent.value = '请联系客服获取详细的开发对接文档'
        dialogVisible.value = true
    } else if (type === 'login') {
        dialogTitle.value = '商户登录'
        dialogContent.value = '请联系客服开通商户账号'
        dialogVisible.value = true
    }
}
</script>

<style scoped lang="scss">
.home-container {
    min-height: 100vh;
    background: linear-gradient(180deg, #f8f9fa 0%, #ffffff 100%);
}

.section-title {
    text-align: center;
    margin-bottom: 48px;

    h2 {
        font-size: 32px;
        color: #1a1a1a;
        margin-bottom: 16px;
    }

    p {
        font-size: 16px;
        color: #666;
    }
}

.main-features {
    padding: 80px 0;

    .features-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }
}

.feature-card {
    background: #fff;
    border-radius: 12px;
    padding: 32px;
    text-align: center;
    transition: all 0.3s ease;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);

    &:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    }

    .feature-icon {
        width: 64px;
        height: 64px;
        margin: 0 auto 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f0f7ff;
        border-radius: 16px;

        i {
            font-size: 28px;
            color: #1677ff;
        }
    }

    h3 {
        font-size: 20px;
        color: #1a1a1a;
        margin-bottom: 16px;
    }

    p {
        font-size: 14px;
        color: #666;
        margin-bottom: 24px;
        line-height: 1.6;
    }

    .feature-tags {
            display: flex;
        flex-wrap: wrap;
        gap: 8px;
        justify-content: center;

        span {
            padding: 4px 12px;
            background: #f5f5f5;
            border-radius: 12px;
            font-size: 12px;
            color: #666;
        }
    }
}

.core-advantages {
    padding: 80px 0;
    background: #fff;

    .advantages-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 32px;
        max-width: 1200px;
            margin: 0 auto;
        padding: 0 20px;
    }
}

.advantage-item {
    display: flex;
    gap: 24px;
    padding: 32px;
    background: #f8f9fa;
    border-radius: 12px;
    transition: all 0.3s ease;

    &:hover {
        background: #f0f7ff;

        .advantage-icon {
            background: #1677ff;

            i {
                color: #fff;
            }
        }
    }

    .advantage-icon {
        width: 48px;
        height: 48px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #fff;
        border-radius: 12px;
        transition: all 0.3s ease;

        i {
            font-size: 24px;
            color: #1677ff;
        }
    }

    .advantage-content {
        h3 {
            font-size: 18px;
            color: #1a1a1a;
            margin-bottom: 16px;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;

            li {
                font-size: 14px;
                color: #666;
                margin-bottom: 8px;
                display: flex;
                align-items: center;

                &:before {
                    content: '';
                    width: 4px;
                    height: 4px;
                    background: #1677ff;
                    border-radius: 50%;
                    margin-right: 8px;
                }
            }
        }
    }
}

.quick-start {
    padding: 80px 0;
    text-align: center;

    .start-content {
        max-width: 600px;
        margin: 0 auto;

        h2 {
            font-size: 32px;
            color: #1a1a1a;
            margin-bottom: 16px;
        }

        p {
            font-size: 16px;
            color: #666;
            margin-bottom: 32px;
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;

            .el-button {
                min-width: 160px;

                i {
                    margin-right: 8px;
                }
            }
        }
    }
}

.contact-dialog {
    :deep(.el-dialog__header) {
        padding: 20px;
        margin: 0;
        text-align: center;
        border-bottom: 1px solid #f0f0f0;
    }

    .contact-content {
        text-align: center;
        padding: 24px;

        i.fa-headphones {
            font-size: 48px;
            color: #1677ff;
            margin-bottom: 16px;
        }

        .contact-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 24px;
            line-height: 1.6;
        }

        .contact-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 16px;

            .info-item {
                display: flex;
                align-items: center;
                padding: 12px;
                border-radius: 4px;

                i {
                    font-size: 20px;
                    color: #1677ff;
                    margin-right: 12px;
                }

                span {
                    font-size: 15px;
                    color: #333;
                }
            }
        }
    }

    .dialog-footer {
        text-align: center;
        padding-top: 16px;

        .el-button {
            width: 120px;
        }
    }
}

@media (max-width: 768px) {
    .features-grid {
        grid-template-columns: 1fr !important;
    }

    .advantages-grid {
        grid-template-columns: 1fr !important;
    }

    .section-title {
        h2 {
            font-size: 24px;
        }
    }

    .quick-start {
        .action-buttons {
            flex-direction: column;

            .el-button {
                width: 100%;
            }
        }
    }
}
</style>
