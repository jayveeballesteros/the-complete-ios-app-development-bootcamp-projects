
struct Enemy {
    var health: Int = 0
    var attackStrength: Int = 0
    
    init(health: Int, attackStrength: Int) {
        self.health = health
        self.attackStrength = attackStrength
    }
    
    mutating func takeDamage(amount: Int) {
        health = health - amount
    }
    
    func move() {
        print("Walk forward")
    }
    
    func attack() {
        print("Land a hit, does \(attackStrength) damage.")
    }
}
