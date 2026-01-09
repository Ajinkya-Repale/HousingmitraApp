package com.MainApp.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MainApp.Entity.Property;
import com.MainApp.Repository.PropertyRepository;

@Service
public class PropertyService {

    @Autowired
    private PropertyRepository pRepo;

    // Add property
    public Property addProperty(Property p) {
        return pRepo.save(p);
    }

    // Update property
    public Property updateProperty(Property p) {
        Optional<Property> existing = pRepo.findById(p.getId());
        if(existing.isPresent()) {
            Property prop = existing.get();
            prop.setPropertyName(p.getPropertyName());
            prop.setPropertyType(p.getPropertyType());
            prop.setRent(p.getRent());
            prop.setStatus(p.getStatus());
            prop.setBlock(p.getBlock());
            return pRepo.save(prop);
        }
        return null;
    }

    // Delete property
    public void deleteProperty(Long id) {
        pRepo.deleteById(id);
    }

    // Get property by id
    public Optional<Property> getPropertyById(Long id) {
        return pRepo.findById(id);
    }

    // Get properties by user
    public List<Property> getPropertiesByUser(Long userId) {
        return pRepo.findByUserId(userId);
    }
}
