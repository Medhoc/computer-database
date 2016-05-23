package com.excilys.computer_database.database.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.excilys.computer_database.entity.Company;

public class CompanyDAO extends DAO<Company> {
    public static final String TABLE_NAME = "company";
    public static final String ID = "company.id", NAME = "company.name";

    private static final String FIND_REQUEST = "SELECT * FROM " + TABLE_NAME + " WHERE " + ID + " = ?",
            FIND_ALL_REQUEST = "SELECT " + ID + "," + NAME + " FROM company",
            INSERT_REQUEST = "INSERT INTO " + TABLE_NAME + " ( " + NAME + " ) VALUES (?) ",
            UPDATE_REQUEST = "UPDATE " + TABLE_NAME + " SET " + NAME + " = ? WHERE " + ID + " = ?",
            DELETE_REQUEST = "DELETE FROM " + TABLE_NAME + " WHERE " + ID + " = ? ";

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public String getFindRequest() {
        return FIND_REQUEST;
    }

    @Override
    public String getFindAllRequest() {
        return FIND_ALL_REQUEST;
    }

    @Override
    public Company unmap(ResultSet rs) throws DAOException {
        try {
            return new Company(rs.getLong(ID), rs.getString(NAME));
        } catch (SQLException e) {
            logger.error(e.getMessage());
            throw new DAOException(e);
        }
    }

    @Override
    public Company create(Company obj) throws DAOException {
        // Exécution de la requête
        try (PreparedStatement stmt = datasource.getConnection().prepareStatement(INSERT_REQUEST,
                Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, obj.getName());

            stmt.executeUpdate();

            // Mise à jour de l'id de l'objet inséré
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.first()) {
                obj.setId(rs.getLong(1));
            } else {
                throw new SQLException("L'insertion n'a pas aboutie");
            }

            return obj;
        } catch (SQLException e) {
            logger.error(e.getMessage());
            throw new DAOException(e);
        }
    }

    @Override
    public Company update(Company obj) throws DAOException {
        try (PreparedStatement stmt = datasource.getConnection().prepareStatement(UPDATE_REQUEST)) {
            stmt.setString(1, obj.getName());
            stmt.setLong(2, obj.getId());

            stmt.executeUpdate();
            return obj;
        } catch (SQLException e) {
            logger.error(e.getMessage());
            throw new DAOException(e);
        }
    }

    @Override
    public void delete(Long id) throws DAOException {
        try (PreparedStatement deleteCompanyStmt = datasource.getConnection().prepareStatement(DELETE_REQUEST)) {
            deleteCompanyStmt.setLong(1, id);
            deleteCompanyStmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }
}
