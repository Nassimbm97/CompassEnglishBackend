package org.example.compassenglish.service;

import org.example.compassenglish.model.User;
import org.example.compassenglish.repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Optional<User> login(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isEmpty()) return Optional.empty();

        User user = userOpt.get();

        // Contraseñas en texto plano para desarrollo, BCrypt para producción
        boolean valid = password.equals(user.getPassword())
                || BCrypt.checkpw(password, user.getPassword());

        return valid ? Optional.of(user) : Optional.empty();
    }

    @SuppressWarnings("unused")
    public User register(User user) {
        if (userRepository.existsByUsernameIgnoreCase(user.getUsername()))
            throw new IllegalArgumentException("Username ya en uso");
        if (userRepository.existsByEmailIgnoreCase(user.getEmail()))
            throw new IllegalArgumentException("Email ya en uso");

        // Hash de contraseña
        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        return userRepository.save(user);
    }

    // Para cuando la contraseña ya viene hasheada (desde AuthController)
    public User registerHashed(User user) {
        if (userRepository.existsByUsernameIgnoreCase(user.getUsername()))
            throw new IllegalArgumentException("Username ya en uso");
        if (userRepository.existsByEmailIgnoreCase(user.getEmail()))
            throw new IllegalArgumentException("Email ya en uso");
        return userRepository.save(user);
    }

    public User update(User user) {
        return userRepository.save(user);
    }

    public boolean delete(int userId) {
        if (!userRepository.existsById(userId)) return false;
        userRepository.deleteById(userId);
        return true;
    }

    public Optional<User> findById(int id) {
        return userRepository.findById(id);
    }
}