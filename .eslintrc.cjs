module.exports = {
  root: true,
  env: {
    node: true,
    es2022: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'prettier',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    project: './tsconfig.json',
  },
  plugins: ['@typescript-eslint', 'import'],
  rules: {
    // TypeScript
    '@typescript-eslint/explicit-function-return-type': 'warn',
    '@typescript-eslint/no-explicit-any': 'warn',
    '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    
    // Import
    'import/order': [
      'error',
      {
        'newlines-between': 'always',
        'alphabetize': { order: 'asc', caseInsensitive: true },
        'groups': ['builtin', 'external', 'internal', 'parent', 'sibling', 'index'],
      },
    ],
    
    // General
    'no-console': 'warn',
    'no-constant-condition': ['error', { checkLoops: false }],
    'prefer-const': 'error',
    'eqeqeq': ['error', 'always'],
    'no-var': 'error',
    'prefer-arrow-callback': 'error',
  },
  ignorePatterns: ['dist/**', 'node_modules/**', '*.d.ts'],
};
