package com.stoopsartsunlimited.auction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;

import com.stoopsartsunlimited.auction.Lot.BiddingStatus;

public class AuctionDataSource {
	private static final String connectionString = "jdbc:mysql://localhost:3306/auction";
	private static final String dbUser = "auction";
	private static final String dbPass = "auction";
	private Connection db;
	
	public AuctionDataSource() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			db = DriverManager.getConnection(connectionString, dbUser, dbPass);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new SQLException(e);
		}
	}
	
	public void close() throws SQLException {
		db.close();
	}
	
	public void put(Account o) throws SQLException {
		if (o.getId() <= 0) {
			PreparedStatement statement = db.prepareStatement(
				"INSERT INTO `auction`.`ACCOUNTS` " +
				"(`NAME`, " +
				"`ADDRESS`, " +
				"`PHONE`, " +
				"`EMAIL`, " +
				"`TAX_ID`, " +
				"`BIDDER_ID`, " +
				"`ACTIVE`) " +
				"VALUES " +
				"(" +
				"?," + // name
				"?," + // address
				"?," + // phone
				"?," + // email 
				"?," + // tax id
				"?," + // bidder id
				"?);", // active
				PreparedStatement.RETURN_GENERATED_KEYS);
			
			statement.setString(1, o.getName());
			statement.setString(2, o.getAddress());
			statement.setString(3, o.getPhone());
			statement.setString(4, o.getEmail());
			statement.setString(5, o.getTaxId());
			statement.setString(6, o.getBidderId());
			statement.setBoolean(7, o.isActive());
			
			statement.executeUpdate();
			ResultSet rs = statement.getGeneratedKeys();
			rs.first();
			o.setId(rs.getInt(1));
		} else {
			// update
			PreparedStatement statement = db.prepareStatement(
				"UPDATE `auction`.`ACCOUNTS` " +
				"SET " +
				"`NAME` = ?, " +
				"`ADDRESS` = ?, " +
				"`PHONE` = ?, " +
				"`EMAIL` = ?, " +
				"`TAX_ID` = ?, " +
				"`BIDDER_ID` = ?, " +
				"`ACTIVE` = ? " +
				//"`CREATED` = ? " +
				"WHERE `ID` = ?; ");
		
			statement.setString(1, o.getName());
			statement.setString(2, o.getAddress());
			statement.setString(3, o.getPhone());
			statement.setString(4, o.getEmail());
			statement.setString(5, o.getTaxId());
			statement.setString(6, o.getBidderId());
			statement.setBoolean(7, o.isActive());
			//statement.setTimestamp(8, new Timestamp(o.getCreated().getTime()));
			statement.setInt(8, o.getId());
			
			statement.executeUpdate();
		}
	}
	
	public Account getAccount(int id) throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`ACCOUNTS`.`ID`, " +
			"`ACCOUNTS`.`NAME`, " +
			"`ACCOUNTS`.`ADDRESS`, " +
			"`ACCOUNTS`.`PHONE`, " +
			"`ACCOUNTS`.`EMAIL`, " +
			"`ACCOUNTS`.`TAX_ID`, " +
			"`ACCOUNTS`.`BIDDER_ID`, " +
			"`ACCOUNTS`.`ACTIVE`, " +
			"`ACCOUNTS`.`CREATED`, " +
			"`ACCOUNTS`.`MODIFIED` " +
			"FROM `auction`.`ACCOUNTS` WHERE `ID` = ?;");
		
		statement.setInt(1, id);
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		if (rs.first()) {
			return new Account(
					rs.getInt("ID"),
					rs.getString("NAME"),
					rs.getString("ADDRESS"),
					rs.getString("PHONE"),
					rs.getString("EMAIL"),
					rs.getString("TAX_ID"),
					rs.getString("BIDDER_ID"),
					rs.getBoolean("ACTIVE"),
					new Date(rs.getTimestamp("CREATED") != null ? rs.getTimestamp("CREATED").getTime() : 0),
					new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
					);
		} else {
			return null;
		}
	}
	
	public Collection<Account> getAllAccounts() throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`ACCOUNTS`.`ID`, " +
			"`ACCOUNTS`.`NAME`, " +
			"`ACCOUNTS`.`ADDRESS`, " +
			"`ACCOUNTS`.`PHONE`, " +
			"`ACCOUNTS`.`EMAIL`, " +
			"`ACCOUNTS`.`TAX_ID`, " +
			"`ACCOUNTS`.`BIDDER_ID`, " +
			"`ACCOUNTS`.`ACTIVE`, " +
			"`ACCOUNTS`.`CREATED`, " +
			"`ACCOUNTS`.`MODIFIED` " +
			"FROM `auction`.`ACCOUNTS`;");
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		LinkedList<Account> r = new LinkedList<Account>();
		while (rs.next()) {
			r.add(new Account(
				rs.getInt("ID"),
				rs.getString("NAME"),
				rs.getString("ADDRESS"),
				rs.getString("PHONE"),
				rs.getString("EMAIL"),
				rs.getString("TAX_ID"),
				rs.getString("BIDDER_ID"),
				rs.getBoolean("ACTIVE"),
				new Date(rs.getTimestamp("CREATED") != null ? rs.getTimestamp("CREATED").getTime() : 0),
				new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
				));
		}
		return r;
	}


	public void put(Lot o) throws SQLException {
		if (o.getId() <= 0) {
			// insert
			PreparedStatement statement = db.prepareStatement(
				"INSERT INTO `auction`.`LOTS` " +
				"(" +
				"`TITLE`, " +
				"`DESCRIPTION`, " +
				"`STATUS`, " +
				"`DECLARED_VALUE`, " +
				"`FINAL_VALUE`, " +
				"`WINNER`, " +
				"`CONTRIBUTOR`, " +
				"`TYPE`) " +
				"VALUES " +
				"(" +
				"?," + // 1 title
				"?," + // 2 description
				"?," + // 3 status
				"?," + // 4 declared value
				"?," + // 5 final value
				"?," + // 6 winner
				"?," + // 7 contributor
				"?" + // 8 type
				");",
				PreparedStatement.RETURN_GENERATED_KEYS);
			
			statement.setString(1, o.getTitle());
			statement.setString(2, o.getDescription());
			statement.setString(3, o.getStatus().toString());
			statement.setDouble(4, o.getDeclaredValue());
			statement.setDouble(5, o.getFinalValue());
			statement.setInt(6, o.getWinner());
			statement.setInt(7, o.getContributor());
			statement.setString(8, o.getType());
			
			statement.executeUpdate();
			ResultSet rs = statement.getGeneratedKeys();
			rs.first();
			o.setId(rs.getInt(1));
		} else {
			// update
			PreparedStatement statement = db.prepareStatement(
				"UPDATE `auction`.`LOTS` " +
				"SET " +
				"`TITLE` = ?, " +
				"`DESCRIPTION` = ?, " +
				"`STATUS` = ?, " +
				"`DECLARED_VALUE` = ?, " +
				"`FINAL_VALUE` = ?, " +
				"`WINNER` = ?, " +
				"`CONTRIBUTOR` = ?, " +
				"`TYPE` = ? " +
				//"`CREATED` = ?" +
				"WHERE `ID` = ?;");
		
			statement.setString(1, o.getTitle());
			statement.setString(2, o.getDescription());
			statement.setString(3, o.getStatus().toString());
			statement.setDouble(4, o.getDeclaredValue());
			statement.setDouble(5, o.getFinalValue());
			statement.setInt(6, o.getWinner());
			statement.setInt(7, o.getContributor());
			statement.setString(8, o.getType());
			//statement.setTimestamp(9, new Timestamp(o.getCreated().getTime()));
			statement.setInt(9, o.getId());
			
			statement.executeUpdate();
		}
	}

	public Lot getLot(int id) throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`LOTS`.`ID`, " +
			"`LOTS`.`TITLE`, " +
			"`LOTS`.`DESCRIPTION`, " +
			"`LOTS`.`STATUS`, " +
			"`LOTS`.`DECLARED_VALUE`, " +
			"`LOTS`.`FINAL_VALUE`, " +
			"`LOTS`.`WINNER`, " +
			"`LOTS`.`CONTRIBUTOR`, " +
			"`LOTS`.`TYPE`, " +
			"`LOTS`.`CREATED`, " +
			"`LOTS`.`MODIFIED` " +
			"FROM `auction`.`LOTS` WHERE `ID` = ?;");
		
		statement.setInt(1, id);
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		if (rs.first()) {
			return new Lot(                        
					rs.getInt("ID"),
					rs.getString("TITLE"),
					rs.getString("DESCRIPTION"),
					BiddingStatus.valueOf(rs.getString("STATUS")),
					rs.getDouble("DECLARED_VALUE"),
					rs.getDouble("FINAL_VALUE"),
					rs.getInt("WINNER"),
					rs.getInt("CONTRIBUTOR"),
					rs.getString("TYPE"),
					new Date(rs.getTimestamp("CREATED") != null ? rs.getTimestamp("CREATED").getTime() : 0),
					new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
					);
		} else {
			return null;
		}
	}
	
	public Collection<Lot> getAllLots() throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`LOTS`.`ID`, " +
			"`LOTS`.`TITLE`, " +
			"`LOTS`.`DESCRIPTION`, " +
			"`LOTS`.`STATUS`, " +
			"`LOTS`.`DECLARED_VALUE`, " +
			"`LOTS`.`FINAL_VALUE`, " +
			"`LOTS`.`WINNER`, " +
			"`LOTS`.`CONTRIBUTOR`, " +
			"`LOTS`.`TYPE`, " +
			"`LOTS`.`CREATED`, " +
			"`LOTS`.`MODIFIED` " +
			"FROM `auction`.`LOTS`;");
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		LinkedList<Lot> r = new LinkedList<Lot>();
		while (rs.next()) {
			r.add(new Lot(                        
				rs.getInt("ID"),
				rs.getString("TITLE"),
				rs.getString("DESCRIPTION"),
				BiddingStatus.valueOf(rs.getString("STATUS")),
				rs.getDouble("DECLARED_VALUE"),
				rs.getDouble("FINAL_VALUE"),
				rs.getInt("WINNER"),
				rs.getInt("CONTRIBUTOR"),
				rs.getString("TYPE"),
				new Date(rs.getTimestamp("CREATED") != null ? rs.getTimestamp("CREATED").getTime() : 0),
				new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
				));
		}
		return r;
	}
	
	public Collection<Lot> getLotsByContributor(int contributor) throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`LOTS`.`ID`, " +
			"`LOTS`.`TITLE`, " +
			"`LOTS`.`DESCRIPTION`, " +
			"`LOTS`.`STATUS`, " +
			"`LOTS`.`DECLARED_VALUE`, " +
			"`LOTS`.`FINAL_VALUE`, " +
			"`LOTS`.`WINNER`, " +
			"`LOTS`.`CONTRIBUTOR`, " +
			"`LOTS`.`TYPE`, " +
			"`LOTS`.`CREATED`, " +
			"`LOTS`.`MODIFIED` " +
			"FROM `auction`.`LOTS` WHERE `CONTRIBUTOR` = ?;");
		
		statement.setInt(1, contributor);
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		LinkedList<Lot> r = new LinkedList<Lot>();
		while (rs.next()) {
			r.add(new Lot(                        
				rs.getInt("ID"),
				rs.getString("TITLE"),
				rs.getString("DESCRIPTION"),
				BiddingStatus.valueOf(rs.getString("STATUS")),
				rs.getDouble("DECLARED_VALUE"),
				rs.getDouble("FINAL_VALUE"),
				rs.getInt("WINNER"),
				rs.getInt("CONTRIBUTOR"),
				rs.getString("TYPE"),
				new Date(rs.getTimestamp("CREATED") != null ? rs.getTimestamp("CREATED").getTime() : 0),
				new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
				));
		}
		return r;
	}
	
	public Collection<Lot> getLotsByWinner(int winner) throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`LOTS`.`ID`, " +
			"`LOTS`.`TITLE`, " +
			"`LOTS`.`DESCRIPTION`, " +
			"`LOTS`.`STATUS`, " +
			"`LOTS`.`DECLARED_VALUE`, " +
			"`LOTS`.`FINAL_VALUE`, " +
			"`LOTS`.`WINNER`, " +
			"`LOTS`.`CONTRIBUTOR`, " +
			"`LOTS`.`TYPE`, " +
			"`LOTS`.`CREATED`, " +
			"`LOTS`.`MODIFIED` " +
			"FROM `auction`.`LOTS` WHERE `WINNER` = ?;");
		
		statement.setInt(1, winner);
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		LinkedList<Lot> r = new LinkedList<Lot>();
		while (rs.next()) {
			r.add(new Lot(                        
				rs.getInt("ID"),
				rs.getString("TITLE"),
				rs.getString("DESCRIPTION"),
				BiddingStatus.valueOf(rs.getString("STATUS")),
				rs.getDouble("DECLARED_VALUE"),
				rs.getDouble("FINAL_VALUE"),
				rs.getInt("WINNER"),
				rs.getInt("CONTRIBUTOR"),
				rs.getString("TYPE"),
				new Date(rs.getTimestamp("CREATED") != null ? rs.getTimestamp("CREATED").getTime() : 0),
				new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
				));
		}
		return r;
	}
	
	public void put(Payment o) throws SQLException {
		if (o.getId() <= 0) {
			// insert
			PreparedStatement statement = db.prepareStatement(
				"INSERT INTO `auction`.`PAYMENTS` " +
				"(" +
				"`ACCOUNT_ID`, " +
				"`AMOUNT`, " +
				"`INSTRUMENT`, " +
				"`COMMENTS`) " +
				"VALUES " +
				"(" +
				"?," + // 1 account id
				"?," + // 2 amount
				"?," + // 3 instrument
				"?" + // 4 comments
				");",
				PreparedStatement.RETURN_GENERATED_KEYS);
			
			statement.setInt(1, o.getAccount());
			statement.setDouble(2, o.getAmount());
			statement.setString(3, o.getInstrument());
			statement.setString(4, o.getComments());
			
			statement.executeUpdate();
			ResultSet rs = statement.getGeneratedKeys();
			rs.first();
			o.setId(rs.getInt(1));
		} else {
			// update
			PreparedStatement statement = db.prepareStatement(
				"UPDATE `auction`.`PAYMENTS` " +
				"SET " +
				"`ACCOUNT_ID` = ?," +
				"`AMOUNT` = ?," +
				"`INSTRUMENT` = ?," +
				"`COMMENTS` = ?," +
				"`RECEIVED` = ?" +
				"WHERE `ID` = ?;");
		
			statement.setInt(1, o.getAccount());
			statement.setDouble(2, o.getAmount());
			statement.setString(3, o.getInstrument());
			statement.setString(4, o.getComments());
			statement.setTimestamp(5, new Timestamp(o.getReceived().getTime()));
			statement.setInt(6, o.getId());
			
			statement.executeUpdate();
		}
	}

	public Payment getPayment(int id) throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`PAYMENTS`.`ID`, " +
			"`PAYMENTS`.`ACCOUNT_ID`, " +
			"`PAYMENTS`.`AMOUNT`, " +
			"`PAYMENTS`.`INSTRUMENT`, " +
			"`PAYMENTS`.`COMMENTS`, " +
			"`PAYMENTS`.`RECEIVED`, " +
			"`PAYMENTS`.`MODIFIED` " +
			"FROM `auction`.`PAYMENTS` WHERE `ID` = ?;");
		
		statement.setInt(1, id);
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		if (rs.first()) {
			return new Payment(
					rs.getInt("ID"),
					rs.getInt("ACCOUNT_ID"),
					rs.getDouble("AMOUNT"),
					rs.getString("INSTRUMENT"),
					rs.getString("COMMENTS"),
					new Date(rs.getTimestamp("RECEIVED") != null ? rs.getTimestamp("RECEIVED").getTime() : 0),
					new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
					);
		} else {
			return null;
		}
	}
	
	public Collection<Payment> getAllPayments() throws SQLException {
		PreparedStatement statement = db.prepareStatement(
			"SELECT " +
			"`PAYMENTS`.`ID`, " +
			"`PAYMENTS`.`ACCOUNT_ID`, " +
			"`PAYMENTS`.`AMOUNT`, " +
			"`PAYMENTS`.`INSTRUMENT`, " +
			"`PAYMENTS`.`COMMENTS`, " +
			"`PAYMENTS`.`RECEIVED`, " +
			"`PAYMENTS`.`MODIFIED` " +
			"FROM `auction`.`PAYMENTS`;");
		
		statement.executeQuery();
		ResultSet rs = statement.getResultSet();
		LinkedList<Payment> r = new LinkedList<Payment>();
		while (rs.next()) {
			r.add(new Payment(
				rs.getInt("ID"),
				rs.getInt("ACCOUNT_ID"),
				rs.getDouble("AMOUNT"),
				rs.getString("INSTRUMENT"),
				rs.getString("COMMENTS"),
				new Date(rs.getTimestamp("RECEIVED") != null ? rs.getTimestamp("RECEIVED").getTime() : 0),
				new Date(rs.getTimestamp("MODIFIED") != null ? rs.getTimestamp("MODIFIED").getTime() : 0)
				));
		}
		return r;
	}
	
}
