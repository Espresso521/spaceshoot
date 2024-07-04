import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_game/emberquest/actors/water_enemy.dart';
import 'package:flutter/services.dart';

import '../ember_quest.dart';
import '../managers/segment_manager.dart';
import '../objects/fireball.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../objects/star.dart';

/// キャラクターの状態
enum KnightState {walk, attack}

class EmberNightPlayer extends SpriteAnimationGroupComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<EmberQuestGame> {
  EmberNightPlayer(this.joystick,this.jumpButton, this.attackButton,
  {
    required super.position,
  }) : super(size: Vector2.all(actorsSize*1.25), anchor: Anchor.center);

  // サイズの定義
  final _knightSize = Vector2(587.0, 707.0);

  final Vector2 velocity = Vector2.zero();
  final Vector2 fromAbove = Vector2(0, -1);
  final double gravity = 15;
  final double jumpSpeed = 500;
  final double moveSpeed = 150;
  final double terminalVelocity = 150;
  int horizontalDirection = 0;

  bool hasJumped = false;
  bool isOnGround = false;
  bool hitByEnemy = false;

  final JoystickComponent joystick;
  final HudButtonComponent jumpButton;
  final HudButtonComponent attackButton;

  @override
  Future<void> onLoad() async {
    // スプライトシートを定義する
    final spriteSheet = SpriteSheet(
      image: await game.images.load('layers/emberknight.png'),
      srcSize: _knightSize,
    );
    jumpButton.onPressed = jump;
    attackButton.onPressed = attackStart;

    // スプライトシートから作成したアニメーションを設定する
    animations = {
      KnightState.walk: spriteSheet.createAnimation(row: 0, to: 10, stepTime: 0.1),
      KnightState.attack: spriteSheet.createAnimation(row: 1, to: 10, stepTime: 0.05, loop: false),
    };

    // その他のプロパティを設定する
    current = KnightState.walk;
    // 攻撃アニメーション終了イベントを設定する
    animationTickers?[KnightState.attack]?.onComplete = attackEnd;

    add(
      CircleHitbox(),
    );
    super.onLoad();
  }

  void jump() {
    if(!hasJumped) {
      hasJumped = true;
    }
  }

  /// 攻撃開始
  void attackStart() {
    current = KnightState.attack;
    game.add(FireBall(position: position));
  }

  /// 攻撃終了
  void attackEnd() async {
    await Future.delayed(const Duration(milliseconds: 100));
    animationTickers?[KnightState.attack]?.reset();
    current = KnightState.walk;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
    return true;
  }

  @override
  void update(double dt) {
    if (!joystick.delta.isZero()) {
      if(joystick.delta.x > 0) {
        horizontalDirection = 1;
      } else if(joystick.delta.x < 0) {
        horizontalDirection = -1;
      } else {
        horizontalDirection = 0;
      }
    } else {
      horizontalDirection = 0;
    }


    velocity.x = horizontalDirection * moveSpeed;
    game.objectSpeed = 0;
    // Prevent ember from going backwards at screen edge.
    if (position.x - 36 <= 0 && horizontalDirection < 0) {
      velocity.x = 0;
    }
    // Prevent ember from going beyond half screen.
    if (position.x + 64 >= game.size.x / 2 && horizontalDirection > 0) {
      velocity.x = 0;
      game.objectSpeed = -moveSpeed;
    }

    // Apply basic gravity.
    velocity.y += gravity;

    // Determine if ember has jumped.
    if (hasJumped) {
      if (isOnGround) {
        velocity.y = -jumpSpeed;
        isOnGround = false;
      }
      hasJumped = false;
    }

    // Prevent ember from jumping to crazy fast.
    velocity.y = velocity.y.clamp(-jumpSpeed, terminalVelocity);

    // Adjust ember position.
    position += velocity * dt;

    // If ember fell in pit, then game over.
    if (position.y > game.size.y + size.y) {
      game.health = 0;
    }

    if (game.health <= 0) {
      removeFromParent();
      joystick.removeFromParent();
      jumpButton.removeFromParent();
      attackButton.removeFromParent();
    }

    // Flip ember if needed.
    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GroundBlock || other is PlatformBlock) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
            intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // If collision normal is almost upwards,
        // ember must be on ground.
        if (fromAbove.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        // Resolve collision by moving ember along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }

    if (other is Star) {
      other.removeFromParent();
      game.starsCollected++;
    }

    if (other is WaterEnemy) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  // This method runs an opacity effect on ember
  // to make it blink.
  void hit() {
    if (!hitByEnemy) {
      game.health--;
      hitByEnemy = true;
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 5,
        ),
      )..onComplete = () {
        hitByEnemy = false;
      },
    );
  }
}