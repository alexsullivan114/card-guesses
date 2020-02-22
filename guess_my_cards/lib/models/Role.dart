enum Role { Master, Guesser }

extension Utils on Role {
  get name => this == Role.Master ? "Master" : "Guesser";
}
