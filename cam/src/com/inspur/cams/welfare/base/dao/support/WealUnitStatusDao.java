package com.inspur.cams.welfare.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealUnitStatusDao;
import com.inspur.cams.welfare.base.data.WealUnitStatus;

/**
 * @title:WealUnitStatusDao
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitStatusDao extends EntityDao<WealUnitStatus> implements
		IWealUnitStatusDao {

	public WealUnitStatusDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return WealUnitStatus.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from WealUnitStatus");
	}

	public DataSet queryStatusAndInfoList(ParameterSet pset) {
		String includeJuniorWealer = (String) pset.getParameter("includeJuniorWealer");
		String morgArea = (String) pset.getParameter("morgArea");
		String serialNum = (String) pset.getParameter("serialNum");
		String companyName = (String) pset.getParameter("companyName");
		String economicNatureCode = (String) pset.getParameter("economicNatureCode");
		String legalPeople = (String) pset.getParameter("legalPeople");
		String address = (String) pset.getParameter("address");
		String status = (String) pset.getParameter("status");
		String regFundBegin = (String) pset.getParameter("regFundBegin");
		String regFundEnd = (String) pset.getParameter("regFundEnd");
		String approveDateBegin = (String) pset.getParameter("approveDateBegin");
		String approveDateEnd = (String) pset.getParameter("approveDateEnd");
		String workerNumBegin = (String) pset.getParameter("workerNumBegin");
		String workerNumEnd = (String) pset.getParameter("workerNumEnd");
		String disNumBegin = (String) pset.getParameter("disNumBegin");
		String disNumEnd = (String) pset.getParameter("disNumEnd");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select p.UNIT_ID,p.TASK_CODE,p.MORG_NAME,p.MORG_AREA,p.SERIAL_NUM,p.COMPANY_NAME,p.ADDRESS,p.LEGAL_PEOPLE,p.ECONOMIC_NATURE_CODE,p.REG_FUND,p.APPROVE_DATE,p.WORKERS_ALL,p.WORKERS_DEFORM from v_unit_statusandinfo p ");
		sql.append(" where 1=1 ");
		if(StringUtils.isNotEmpty(morgArea)){
			sql.append(" AND p.MORG_AREA LIKE ? ");
			typeList.add(Types.VARCHAR);
			if(morgArea.indexOf("000")!=-1){//找到string时走下面的语句，找不到时走else
				if("0".equals(includeJuniorWealer)){
					argsList.add(morgArea);
				}else {
					argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
				}
			}else {
				argsList.add(morgArea+"%");
			}
		}
		if (StringUtils.isNotEmpty(serialNum)) {
			sql.append(" and p.SERIAL_NUM=?  ");
			argsList.add(serialNum);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyName)) {
			sql.append(" and p.COMPANY_NAME like ? ");
			argsList.add(companyName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(economicNatureCode)) {
			sql.append(" and p.ECONOMIC_NATURE_CODE=?  ");
			argsList.add(economicNatureCode);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(legalPeople)) {
			sql.append(" and p.LEGAL_PEOPLE=?  ");
			argsList.add(legalPeople);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(address)) {
			sql.append(" and p.ADDRESS=?  ");
			argsList.add(address);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(status)) {
			sql.append(" and p.STATUS=?  ");
			argsList.add(status);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(regFundBegin)) {
			sql.append(" and p.REG_FUND >= ?  ");
			argsList.add(regFundBegin);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(regFundEnd)) {
			sql.append(" and p.REG_FUND <= ? ");
			argsList.add(regFundEnd);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(approveDateBegin)) {
			sql.append(" and p.APPROVE_DATE >= ?  ");
			argsList.add(approveDateBegin);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(approveDateEnd)) {
			sql.append(" and p.APPROVE_DATE <= ?  ");
			argsList.add(approveDateEnd);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(workerNumBegin)) {
			sql.append(" and p.WORKERS_ALL >= ?  ");
			argsList.add(workerNumBegin);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(workerNumEnd)) {
			sql.append(" and p.WORKERS_ALL <= ?  ");
			argsList.add(workerNumEnd);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(disNumBegin)) {
			sql.append(" and p.WORKERS_DEFORM >= ?  ");
			argsList.add(disNumBegin);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(disNumEnd)) {
			sql.append(" and p.WORKERS_DEFORM <= ?  ");
			argsList.add(disNumEnd);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		return ds;
	}
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
	 * @author wangziming
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: TODO(excel分页信息B) 
	 * @author wangziming
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit;
	}
	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}
}
