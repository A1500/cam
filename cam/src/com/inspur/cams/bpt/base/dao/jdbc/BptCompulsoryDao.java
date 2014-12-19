package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.bpt.base.dao.IBptCompulsoryDao;
import com.inspur.cams.bpt.base.data.BptCompulsory;
import com.inspur.cams.bpt.util.FilterLimit;

/**
 * @title:BptCompulsoryDao
 * @description:
 * @author:
 * @since:2011-06-05
 * @version:1.0
 */
public class BptCompulsoryDao extends EntityDao<BptCompulsory> implements
		IBptCompulsoryDao {

	@Override
	public Class<BptCompulsory> getEntityClass() {

		return BptCompulsory.class;
	}

	/**
	 * 以家庭行政区划、姓名、性别、身份证号、民族为条件查询
	 */
	public DataSet queryCompulsory(ParameterSet pSet) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String domicileCode = (String) pSet.getParameter("domicileCode");
		String name = (String) pSet.getParameter("name");
		String sex = (String) pSet.getParameter("sex");
		String idCard = (String) pSet.getParameter("idCard");
		String nation = (String) pSet.getParameter("nation");
		String organCode = (String) pSet.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.ID, T.NAME AS COMPULSORY_NAME, SEX, ID_CARD, BIRTHDAY, NATION,\n");
		sql.append("       DOMICILE_CODE, SPECIAL_SETTING_NO, COMPOSED_PORTRAIT, ADDRESS,\n"); 
		sql.append("       TEL_CONTACT, C.NAME AS CITY_NAME\n"); 
		sql.append("  FROM BPT_COMPULSORY T, DIC_CITY C\n"); 
		sql.append(" WHERE T.DOMICILE_CODE = C.ID ");

		if (domicileCode != null && !domicileCode.equals("")) {
			domicileCode =FilterLimit.filterByOrganCode(sql,domicileCode);
			argsList.add(domicileCode);
		} else {
			organCode =FilterLimit.filterByOrganCode(sql,organCode);
			argsList.add(organCode);
		}
		typeList.add(Types.VARCHAR);
		
		if (name != null && !name.equals("")) {
			sql.append(" AND NAME LIKE ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(name+"%");
		}
		if (sex != null && !sex.equals("")) {
			sql.append(" AND SEX = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sex);
		}
		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if (nation != null && !nation.equals("")) {
			sql.append(" AND NATION = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(nation);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, pSet.getPageStart(), pSet.getPageLimit(), true);
		}
		return ds;
	}

	/**
	 * 修改查询
	 */
	public DataSet queryUpdateCompulsory(ParameterSet pSet) {
		String id = (String) pSet.getParameter("id");
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("SELECT T.ID, T.NAME AS COMPULSORY_NAME, SEX, ID_CARD, BIRTHDAY, NATION,\n");
		sqlBuffer.append("       DOMICILE_CODE, SPECIAL_SETTING_NO, COMPOSED_PORTRAIT, ADDRESS,\n"); 
		sqlBuffer.append("       TEL_CONTACT, POSTCODE, FATHER_NAME, FATHER_UNIT, FATHER_CONTACT,\n"); 
		sqlBuffer.append("       MOTHER_NAME, MOTHER_UNIT, MOTHER_CONTACT, BANK, ACCOUNT_CODE, T.NOTE,\n"); 
		sqlBuffer.append("       T.CONSCRIPT_DATE, T.DOMICILE_TYPE, C.NAME AS CITY_NAME\n"); 
		sqlBuffer.append("  FROM BPT_COMPULSORY T, DIC_CITY C\n"); 
		sqlBuffer.append(" WHERE T.DOMICILE_CODE = C.ID);");
		if (id != null && !id.equals("")) {
			sqlBuffer.append(" AND T.ID = '" + id + "'");
		}
		DataSet dSet = this.executeDataset(sqlBuffer.toString(),new int[]{Types.VARCHAR},new Object[]{id}, pSet
				.getPageStart(), pSet.getPageLimit(), true);
		dSet.addField("CITY_NAME");
		Record record = dSet.getRecord(0);
		record.set("id", record.get("ID"));
		record.set("name", record.get("COMPULSORY_NAME"));
		record.set("sex", record.get("SEX"));
		record.set("idCard", record.get("ID_CARD"));
		record.set("birthday", record.get("BIRTHDAY"));
		record.set("nation", record.get("NATION"));
		record.set("specialSettingNo", record.get("SPECIAL_SETTING_NO"));
		record.set("composedPortrait", record.get("COMPOSED_PORTRAIT"));
		record.set("telContact", record.get("TEL_CONTACT"));
		record.set("postcode", record.get("POSTCODE"));
		record.set("conscriptDate", record.get("CONSCRIPT_DATE"));
		record.set("domicileType", record.get("DOMICILE_TYPE"));
		record.set("domicileName", record.get("CITY_NAME"));
		record.set("domicileCode", record.get("DOMICILE_CODE"));
		record.set("address", record.get("ADDRESS"));
		record.set("fatherName", record.get("FATHER_NAME"));
		record.set("fatherUnit", record.get("FATHER_UNIT"));
		record.set("fatherContact", record.get("FATHER_CONTACT"));
		record.set("motherName", record.get("MOTHER_NAME"));
		record.set("motherUnit", record.get("MOTHER_UNIT"));
		record.set("motherContact", record.get("MOTHER_CONTACT"));
		record.set("bank", record.get("BANK"));
		record.set("accountCode", record.get("ACCOUNT_CODE"));
		record.set("note", record.get("NOTE"));
		DataSet dataSet = new DataSet(record);
		return dataSet;
	}
}
