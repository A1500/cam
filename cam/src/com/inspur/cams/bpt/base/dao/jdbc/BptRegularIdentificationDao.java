package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptRegularIdentificationDao;
import com.inspur.cams.bpt.base.data.BptRegularIdentification;
import com.inspur.cams.bpt.util.FilterLimit;

/**
 * @title:BptRegularIdentificationDao
 * @description:
 * @author:
 * @since:2011-05-27
 */
public class BptRegularIdentificationDao extends
		EntityDao<BptRegularIdentification> implements
		IBptRegularIdentificationDao {

	public BptRegularIdentificationDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<BptRegularIdentification> getEntityClass() {
		return BptRegularIdentification.class;
	}


	// 查询是否认证
	public DataSet queryRI(ParameterSet pSet) {
		String peopleId = (String) pSet.getParameter("peopleId");
		StringBuffer stringBuffer = new StringBuffer(
				"SELECT IDENTI_FLAG FROM BPT_REGULAR_IDENTIFICATION ");
		if (peopleId != null && !"".equals(peopleId)) {
			stringBuffer.append("WHERE PEOPLE_ID = ? ");
		}

		return this.executeDataset(stringBuffer.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId}, true);
	}

	// 查询验证人员信息
	public DataSet queryRegIdenti(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT A.PEOPLE_AGE, A.FULL_NAME as DIC_CITY_NAME, A.PEOPLE_ID AS PEOPLE_ID, A.NAME AS NAME,\n");
		sql.append("       A.ID_CARD AS ID_CARD, A.SEX AS SEX, NATION, OBJECT_STATE,\n"); 
		sql.append("       A.OBJECT_TYPE AS OBJECT_TYPE, IDENTIFICATION_DATE, IDENTI_FLAG\n"); 
		sql.append("  FROM v_bpt_object_union A ,BPT_REGULAR_IDENTIFICATION R \n"); 
		sql.append("  WHERE\n"); 
		sql.append("     A.PEOPLE_ID = R.PEOPLE_ID(+)\n"); 
		String domicileCode = (String) pset.getParameter("domicileCode");
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String year = (String) pset.getParameter("year");
		String objectState = (String) pset.getParameter("objectState");
		String objectType = (String) pset.getParameter("objectType");
		String identiFlag = (String) pset.getParameter("identiFlag");
		String organCode = (String) pset.getParameter("organCode");

		String ageBegin = (String) pset.getParameter("ageBegin");
		String ageEnd = (String) pset.getParameter("ageEnd");

		if (domicileCode != null && !domicileCode.equals("")) {
			domicileCode=FilterLimit.filterByOrganCode(sql,domicileCode);
			argsList.add(domicileCode);
		} else {
			organCode=FilterLimit.filterByOrganCode(sql,organCode);
			argsList.add(organCode);
		}
		typeList.add(Types.VARCHAR);
		if (name != null && !name.equals("")) {
			sql.append(" AND A.NAME like '%'|| ? ||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}

		if (idCard != null && !idCard.equals("")) {
			sql.append(" AND A.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}

		if (year != null && !year.equals("")) {
			if (identiFlag != null && !identiFlag.equals("")) {
				if (identiFlag.equals("1")) {
					sql.append("AND IDENTI_FLAG = '1' AND A.PEOPLE_ID=R.PEOPLE_ID AND SUBSTR(R.IDENTIFICATION_DATE,1,4)= ? ");
				} else {
					sql.append("AND NOT EXISTS (SELECT PEOPLE_ID FROM BPT_REGULAR_IDENTIFICATION I WHERE IDENTI_FLAG = '1' AND A.PEOPLE_ID=I.PEOPLE_ID AND SUBSTR(I.IDENTIFICATION_DATE,1,4)= ?) ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(year);
			}
		} else {
			if (identiFlag != null && !identiFlag.equals("")) {
				if (identiFlag.equals("1")) {
					sql.append("AND IDENTI_FLAG = '1' AND A.PEOPLE_ID=R.PEOPLE_ID");
				} else {
					sql.append("AND NOT EXISTS (SELECT PEOPLE_ID FROM  BPT_REGULAR_IDENTIFICATION I WHERE IDENTI_FLAG = '1' AND A.PEOPLE_ID=I.PEOPLE_ID )");
				}
			}
		}
		if (objectType != null && !objectType.equals("")) {
			sql.append(" AND A.OBJECT_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(objectType);
		}
		if (objectState != null && !objectState.equals("")) {
			sql.append(" AND A.OBJECT_STATE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}
		/*if (objectType != null && !objectType.equals("")) {
			switch (Integer.valueOf(objectType)) {
			case 11:
				sql.append(" AND DISABILITY_TYPE_CODE='11'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DISABILITY_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 12:
				sql.append(" AND DISABILITY_TYPE_CODE='12'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DISABILITY_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 13:
				sql.append(" AND DISABILITY_TYPE_CODE='13'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DISABILITY_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 14:
				sql.append(" AND DISABILITY_TYPE_CODE='14'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DISABILITY_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 15:
				sql.append(" AND DISABILITY_TYPE_CODE='15'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DISABILITY_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 21:
				sql.append(" AND DEPENDANT_TYPE_CODE='21'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DEPENDANT_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 22:
				sql.append(" AND DEPENDANT_TYPE_CODE='22'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DEPENDANT_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 23:
				sql.append(" AND DEPENDANT_TYPE_CODE='23'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DEPENDANT_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 31:
				sql.append(" AND REDA_TYPE_CODE='31'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND REDA_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 32:
				sql.append(" AND REDA_TYPE_CODE='32'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND REDA_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 33:
				sql.append(" AND REDA_TYPE_CODE='33'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND REDA_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 41:
				sql.append(" AND DEMOBILIZED_TYEP_CODE='41'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DEMOBILIZED_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 42:
				sql.append(" AND DEMOBILIZED_TYEP_CODE='42'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND DEMOBILIZED_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 51:
				sql.append(" AND WAR_TYPE_CODE='51'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND WAR_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			case 52:
				sql.append(" AND WAR_TYPE_CODE='52'");
				if (objectState != null && !objectState.equals("")) {
					sql.append(" AND WAR_STATE_CODE= ? ");
					typeList.add(Types.VARCHAR);
					argsList.add(objectState);
				}
				break;
			}
			
		}*/

		/*if (objectState != null && !objectState.equals("")) {
			sql.append("AND (DISABILITY_STATE_CODE = ? OR DEPENDANT_TYPE_CODE = ? OR\n");
			sql.append("       REDA_STATE_CODE = ? OR DEMOBILIZED_STATE_CODE = ? OR\n"); 
			sql.append("       WAR_STATE_CODE = ? )");
			typeList.add(Types.VARCHAR);typeList.add(Types.VARCHAR);typeList.add(Types.VARCHAR);typeList.add(Types.VARCHAR);typeList.add(Types.VARCHAR);
			argsList.add(objectState);argsList.add(objectState);argsList.add(objectState);argsList.add(objectState);argsList.add(objectState);
		}*/

		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND A.PEOPLE_AGE >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(Integer.parseInt(ageBegin));
		}

		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND A.PEOPLE_AGE <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(Integer.parseInt(ageEnd));
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

	// 根据peopleId查询认证信息
	/*public DataSet queryRIdentification(ParameterSet pSet) {
		String peopleId = (String) pSet.getParameter("PEOPLE_ID");
		String sqlString = "SELECT T.IDENTIFICATION_ID,T.PEOPLE_ID,B.NAME,B.ID_CARD,T.OBJECT_TYPE,T.IDENTIFICATION_DATE,"
				+ "T.IDENTIFICATION_RESULT,T.NOTE,P.DISABILITY_TYPE_CODE,P.DEPENDANT_TYPE_CODE,P.DEMOBILIZED_TYEP_CODE,P.WAR_TYPE_CODE"
				+ " FROM BPT_REGULAR_IDENTIFICATION T,BPT_PEOPLE P,BASEINFO_PEOPLE B WHERE T.PEOPLE_ID = P.PEOPLE_ID AND T.PEOPLE_ID = B.PEOPLE_ID";
		if (peopleId != null && !"".equals(peopleId)) {
			sqlString += " AND T.PEOPLE_ID = '" + peopleId + "'";
		}

		DataSet dSet = this.executeDataset(sqlString, pSet.getPageStart(), pSet
				.getPageLimit(), true);
		return dSet;
	}*/

	// 修改BPT_REGULAR_IDENTIFICATION
	public void update(ParameterSet pSet) {
		this.update(pSet);
	}

}
