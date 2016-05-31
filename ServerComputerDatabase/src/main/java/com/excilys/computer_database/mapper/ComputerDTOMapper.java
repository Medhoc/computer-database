package com.excilys.computer_database.mapper;

import org.springframework.stereotype.Component;

import com.excilys.computer_database.database.dtos.ComputerDTO;
import com.excilys.computer_database.entity.Company;
import com.excilys.computer_database.entity.Computer;

@Component
public class ComputerDTOMapper{

    public ComputerDTO unmap(Computer c) {
        return new ComputerDTO(c);
    }
    public Computer map(ComputerDTO dto) {
        Computer c = new Computer.ComputerBuilder(dto.getName()).introduced(dto.getIntroduced()).discontinued(dto.getDiscontinued()).company(new Company()).build();
        c.getCompany().setId(dto.getId());
        c.getCompany().setName(dto.getName());
        return c;
    }
}