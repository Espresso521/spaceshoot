import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'Bullet.dart';
import 'Enemy.dart';
import 'Explosion.dart';
import 'SpaceShooterGame.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Player()
      : super(
          size: Vector2(75, 112.5),
          anchor: Anchor.center,
        );

  late final SpawnComponent _bulletSpawner;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );

    position = game.size / 2;

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                -height / 4,
              ),
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);

    add(RectangleHitbox());
  }

  void move(Vector2 delta) {
    position.add(delta);

    // Constrain the position within screen bounds
    position.x = position.x.clamp(size.x / 2, game.size.x - size.x / 2);
    position.y = position.y.clamp(0.0, game.size.y - size.y / 2);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
      game.add(Explosion(
        position: position,
        onComplete: () {
          // game.showGameOverMenuN();
          game.showGameOverMenu(game.buildContext!);
          game.pauseEngine();
        },
      ));
    }
  }
}
