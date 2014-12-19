package com.inspur.cams.welfare.base.dao.support;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.welfare.base.dao.IWealFitStatusDao;
import com.inspur.cams.welfare.base.data.WealFitStatus;

/**
 * @title:WealFitStatusDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitStatusDao extends EntityDao<WealFitStatus> implements IWealFitStatusDao{

 	public WealFitStatusDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitStatus.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitStatus");
	}
   
   //假肢装配企业基本信息查询
   public DataSet queryInfoBySql(ParameterSet pset) {
	   List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String serialNum = (String) pset.getParameter("serialNum");
		String companyName = (String) pset.getParameter("companyName");
		String legalPeople = (String) pset.getParameter("legalPeople");
		String economicNatureCode = (String) pset.getParameter("economicNatureCode");
		//String morgArea = (String) pset.getParameter("morgArea");
		String status = (String) pset.getParameter("status");
		StringBuffer sql = new StringBuffer("");
			sql.append("SELECT A.FIT_ID,A.TASK_CODE,A.STATUS,A.NEXT_CHECK,A.NEXT_CHAGNE_CERT,A.APPLY_YEAR,A.SERIAL_NUM,A.COMPANY_NAME,A.ADDRESS,A.POST_CODE,A.LEGAL_PEOPLE,A.LEGAL_ID_CARD,A.LEGAL_PHONE,A.LEGAL_TELPHONE,A.LEGAL_EMAIL,A.AGENT_PEOPLE,A.AGENT_ID_CARD,A.AGENT_PHONE,A.AGENT_TELPHONE,A.AGENT_EMAIL,A.WEB_ADDRESS,A.ECONOMIC_NATURE_CODE,A.ECONOMIC_NATURE_NAME,A.ORGAN_CODE,A.LICENSE_CODE,A.REGISTRATION_CODE,A.OPERATE_AREA,A.PRODUCT_AREA,A.RECOVERY_AREA,A.RECEPTION_AREA,A.TRAIN_AREA,A.TREATMENT_AREA,A.WORK_AREA,A.LEISURE_AREA,A.OTHER_AREA,A.REG_FUND,A.APPROVE_DATE,A.ISSUEL_ORGAN,A.ISSUEL_DATE,A.BUSINESS_SCOPE,A.COGNIZANCE_DATE,D.NAME MORG_NAME,A.MORG_AREA ,NVL(B.WORKER_NUM,0) WORKER_NUM,NVL(B.DIS_NUM,0) DIS_NUM FROM WEAL_FIT_STATUS A  ");
			sql.append(",( SELECT TASK_CODE ,COUNT(*) WORKER_NUM,COUNT(DISABILITY_TYPE) DIS_NUM FROM WEAL_WORKER GROUP BY TASK_CODE  ) B");
			sql.append(",DIC_CITY D WHERE A.TASK_CODE=B.TASK_CODE(+) AND A.MORG_AREA=D.ID ");
			if(StringUtils.isNotEmpty(status)){
				sql.append(" AND A.STATUS = ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(status);
			}
			if(StringUtils.isNotEmpty(serialNum)){
				sql.append(" AND A.SERIAL_NUM LIKE ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(serialNum);
			}
			if(StringUtils.isNotEmpty(companyName)){
				sql.append(" AND A.COMPANY_NAME LIKE ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(companyName);
			}
/*			if(StringUtils.isNotEmpty(morgArea)){
				sql.append(" AND A.MORG_AREA LIKE ? ");
				typeList.add(Types.VARCHAR);
				if(morgArea.indexOf("000")!=-1){
					objsList.add(getAreaCodeLikePrefix(morgArea)+"%");
				}else {
					objsList.add(morgArea+"%");
				}
			}*/
			if(StringUtils.isNotEmpty(legalPeople)){
				sql.append(" AND A.LEGAL_PEOPLE LIKE ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(legalPeople);
			}
			if(StringUtils.isNotEmpty(economicNatureCode)){
				sql.append(" AND A.ECONOMIC_NATURE_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(economicNatureCode);
			}
			//注册资金区间
			String regFunds = StrUtil.n2b((String) pset.getParameter("regFunds"));
			if(StringUtils.isNotEmpty(regFunds)){
				sql.append(" AND A.REG_FUND>=? ");
				typeList.add(Types.DECIMAL);
				objsList.add(regFunds);
			}
			String regFunde = StrUtil.n2b((String) pset.getParameter("regFunde"));
			if(StringUtils.isNotEmpty(regFunde)){
				sql.append(" AND A.REG_FUND<=? ");
				typeList.add(Types.DECIMAL);
				objsList.add(regFunde);
			}
			//职工人数区间
			String workerNums = StrUtil.n2b((String) pset.getParameter("workerNums"));
			if(StringUtils.isNotEmpty(workerNums)){
				sql.append(" AND B.WORKER_NUM>=? ");
				typeList.add(Types.DECIMAL);
				objsList.add(workerNums);
			}
			String workerNume = StrUtil.n2b((String) pset.getParameter("workerNume"));
			if(StringUtils.isNotEmpty(workerNume)){
				sql.append(" AND B.WORKER_NUM<=? ");
				typeList.add(Types.DECIMAL);
				objsList.add(workerNume);
			}
			//残疾职工数量区间
			String disNums = StrUtil.n2b((String) pset.getParameter("disNums"));
			if(StringUtils.isNotEmpty(disNums)){
				sql.append(" AND B.DIS_NUM>=? ");
				typeList.add(Types.DECIMAL);
				objsList.add(disNums);
			}
			String disNume = StrUtil.n2b((String) pset.getParameter("disNume"));
			if(StringUtils.isNotEmpty(disNume)){
				sql.append(" AND B.DIS_NUM<=? ");
				typeList.add(Types.DECIMAL);
				objsList.add(disNume);
			}
			//成立起止时间区间
			String cognizanceDateQuerys = (String) pset.getParameter("cognizanceDateQuerys");
			if(StringUtils.isNotEmpty(cognizanceDateQuerys)){
				sql.append(" AND A.COGNIZANCE_DATE >= ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(cognizanceDateQuerys);
			}
			String cognizanceDateQuerye = (String) pset.getParameter("cognizanceDateQuerye");
			if(StringUtils.isNotEmpty(cognizanceDateQuerye)){
				sql.append(" AND A.COGNIZANCE_DATE <= ? ");
				typeList.add(Types.VARCHAR);
				objsList.add(cognizanceDateQuerye);
			}
			sql.append("ORDER BY A.MORG_AREA ASC");
			
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(),getDsStart(pset), getDsLimit(pset), true);
		}
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
