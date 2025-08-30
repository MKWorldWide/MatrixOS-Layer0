import { describe, it, expect, beforeEach } from 'vitest';
import { Matrix, matrix } from '../core/Matrix';

describe('Matrix', () => {
  let testMatrix: Matrix;

  beforeEach(() => {
    testMatrix = new Matrix('test-version');
  });

  describe('getVersion()', () => {
    it('should return the correct version', () => {
      expect(testMatrix.getVersion()).toBe('test-version');
    });
  });

  describe('initialize()', () => {
    it('should initialize without errors', async () => {
      await expect(testMatrix.initialize()).resolves.not.toThrow();
    });
  });

  describe('isReady()', () => {
    it('should return true after initialization', async () => {
      await testMatrix.initialize();
      expect(testMatrix.isReady()).toBe(true);
    });
  });

  describe('singleton instance', () => {
    it('should be an instance of Matrix', () => {
      expect(matrix).toBeInstanceOf(Matrix);
    });

    it('should have a default version', () => {
      expect(matrix.getVersion()).toBe('1.0.0');
    });
  });
});
