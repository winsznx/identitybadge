/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    transpilePackages: ['@identitybadge/shared', '@identitybadge/base-adapter', '@identitybadge/stacks-adapter'],
};

export default nextConfig;
