package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.bptinstitution.dao.IBptGloriousDetailDao;
import com.inspur.cams.bpt.bptinstitution.data.BptGloriousDetail;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.comm.util.StrUtil;


/**
 * @title:BptGloriousInstituteDao
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
*/
 public class BptGloriousDetailDao extends EntityDao<BptGloriousDetail> implements IBptGloriousDetailDao{

 	public BptGloriousDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return BptGloriousDetail.class;
	}

	public void batchDeleteByBptGloriousInstitute(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BPT_GLORIOUS_DETAIL where GLORIOUS_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	//删除光荣院年度信息
	public void batchDeleteDetail(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BPT_GLORIOUS_DETAIL where ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	/**
	 * 查询光荣院
	 * @param pset
	 * @return
	 */
	public DataSet queryGlorious(ParameterSet pset) {
		DataSet ds=new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		List<Object> argsList = new ArrayList<Object>();
		String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
		if(domicileCode.indexOf("0000000000")!=-1){
			argsList.add(domicileCode.subSequence(0, domicileCode.indexOf("0000000000"))+"%");
		}else if(domicileCode.indexOf("00000000")!=-1){
			argsList.add(domicileCode.subSequence(0, domicileCode.indexOf("00000000"))+"%");
		}else if(domicileCode.indexOf("000000")!=-1){
			argsList.add(domicileCode.subSequence(0, domicileCode.indexOf("000000"))+"%");
		}else if(domicileCode.indexOf("000")!=-1){
			argsList.add(domicileCode.subSequence(0, domicileCode.indexOf("000"))+"%");
		}else{
			argsList.add(domicileCode+"%");
		}
		String cxsj=(String) pset.getParameter("cxsj");
		argsList.add(cxsj);
		sql.append("SELECT A.DOMICILE_CODE,                            								\n");
		sql.append("       C.NAME,                              									\n");
		sql.append("	   A.UNIT_FULLNAME,                           								\n");
		sql.append("       A.YEARS,                            										\n");
		sql.append("       A.CREATION_DATE,                               							\n");
		sql.append("       A.BUILD_STATE,                               							\n");
		sql.append("       A.BUILDINGAPPROACH,                                						\n");
		sql.append("       A.APPROVAL,                             									\n");
		sql.append("       NVL(A.PREPARE_NUM, 0) PREPARE_NUM,                               		\n");
		sql.append("       NVL(A.BED_NUM, 0) BED_NUM,                         						\n");
		sql.append("       NVL(A.COUNTYFUNDS, 0) + NVL(A.CITYFUNDS, 0) +                         	\n");
		sql.append("       NVL(A.PROVINCEFUNDS, 0) + NVL(A.CENTRAL_FUNDS, 0) TOTAL_FUNDS,          	\n");
		sql.append("       NVL(A.COUNTYFUNDS, 0) COUNTYFUNDS,                            			\n");
		sql.append("       NVL(A.CITYFUNDS, 0) CITYFUNDS,                  							\n");
		sql.append("       NVL(A.PROVINCEFUNDS, 0) PROVINCEFUNDS,                            		\n");
		sql.append("       NVL(A.CENTRAL_FUNDS, 0) CENTRAL_FUNDS,                  					\n");
		sql.append("       NVL(A.PROVINCEFUNDS, 0) + NVL(A.CENTRAL_FUNDS, 0) ABOVE_CITYFUNDS,      	\n");
		sql.append("       NVL(B.SPECIALASSISTANCE, 0) SPECIALASSISTANCE,                    		\n");
		sql.append("       NVL(A.THREE_CATEGORY, 0) + NVL(A.THREE_RED_NUM, 0) +                   	\n");
		sql.append("       NVL(A.MAIM_NUM, 0) + NVL(A.DEMOBILIZE_NUM, 0) +                      	\n");
		sql.append("       NVL(A.VETERANE_NUM, 0) OTHER_NUM,                       					\n");
		sql.append("       NVL(A.CARE_ROTATION, 0) CARE_ROTATION,                               	\n");
		sql.append("       NVL(B.GLORYROOM, 0) GLORYROOM,                 							\n");
		sql.append("       NVL(A.CARE_PEOPLE, 0) CARE_PEOPLE                        				\n");
		sql.append("  FROM BPT_GLORIOUS_DETAIL A           											\n");
		sql.append("  LEFT JOIN BPT_OTHERPROVIDE B      											\n");
		sql.append("    ON A.DOMICILE_CODE = B.DOMICILECODE                          				\n");
		sql.append("   AND A.YEARS = B.YEARS                            							\n");
		sql.append("   AND A.UNIT_FULLNAME = B.AREA 												\n");
		sql.append("  JOIN DIC_CITY C                 												\n");
		sql.append("    ON A.DOMICILE_CODE = C.ID                   								\n");
		sql.append(" WHERE A.DOMICILE_CODE LIKE ?                         							\n");
		sql.append("   AND A.YEARS = ?                           									\n");
		String unitFullname=StrUtil.n2b((String)pset.getParameter("unitFullname"));//光荣院名称
		if(StringUtils.isNotEmpty(unitFullname)){
			sql.append("   AND A.UNIT_FULLNAME like ?                       						\n");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+unitFullname+"%");
		}
		String buildState=StrUtil.n2b((String)pset.getParameter("buildState"));//建设状况
		if(StringUtils.isNotEmpty(buildState)){
			sql.append("   AND A.BUILD_STATE = ?                 									\n");
			typeList.add(Types.VARCHAR);
			argsList.add(buildState);
		}
		String buildingapproach=StrUtil.n2b((String)pset.getParameter("buildingapproach"));//建设方式
		if(StringUtils.isNotEmpty(buildingapproach)){
			sql.append("   AND A.BUILDINGAPPROACH = ?                     							\n");
			typeList.add(Types.VARCHAR);
			argsList.add(buildingapproach);
		}

		String approval=StrUtil.n2b((String)pset.getParameter("approval"));//有无编委批文
		if(StringUtils.isNotEmpty(approval)){
			sql.append("   AND A.APPROVAL = ?                     									\n");
			typeList.add(Types.VARCHAR);
			argsList.add(approval);
		}
		String prepareNum=StrUtil.n2b((String)pset.getParameter("prepareNum"));
		if(StringUtils.isNotEmpty(prepareNum)){
			sql.append("   AND A.PREPARE_NUM > 0                     								\n");
		}
		String bedNum=StrUtil.n2b((String)pset.getParameter("bedNum"));
		if(StringUtils.isNotEmpty(bedNum)){
			sql.append("   AND A.BED_NUM > 0                     									\n");
		}
		String totalFunds=StrUtil.n2b((String)pset.getParameter("totalFunds"));
		if(StringUtils.isNotEmpty(totalFunds)){
			sql.append("   AND (NVL(A.COUNTYFUNDS, 0) + NVL(A.CITYFUNDS, 0)+ 						\n");
			sql.append("	 	NVL(A.PROVINCEFUNDS, 0) + NVL(A.CENTRAL_FUNDS, 0)) > 0    			\n");
		}
		String countyfunds=StrUtil.n2b((String)pset.getParameter("countyfunds"));
		if(StringUtils.isNotEmpty(countyfunds)){
			sql.append("   AND A.COUNTYFUNDS > 0                     								\n");
		}
		String cityfunds=StrUtil.n2b((String)pset.getParameter("cityfunds"));
		if(StringUtils.isNotEmpty(cityfunds)){
			sql.append("   AND A.CITYFUNDS > 0                     									\n");
		}
		String aboveCityfunds=StrUtil.n2b((String)pset.getParameter("aboveCityfunds"));
		if(StringUtils.isNotEmpty(aboveCityfunds)){
			sql.append("   AND (NVL(A.PROVINCEFUNDS, 0) + NVL(A.CENTRAL_FUNDS, 0)) > 0              \n");
		}
		String specialassistance=StrUtil.n2b((String)pset.getParameter("specialassistance"));
		if(StringUtils.isNotEmpty(specialassistance)){
			sql.append("   AND B.SPECIALASSISTANCE > 0                     							\n");
		}
		String otherNum=StrUtil.n2b((String)pset.getParameter("otherNum"));
		if(StringUtils.isNotEmpty(otherNum)){
			sql.append("   AND (NVL(A.THREE_CATEGORY, 0) + NVL(A.THREE_RED_NUM, 0) +               	\n");
			sql.append("       	NVL(A.MAIM_NUM, 0) + NVL(A.DEMOBILIZE_NUM, 0) +                     \n");
			sql.append("       	NVL(A.VETERANE_NUM, 0)) > 0                     					\n");
		}
		String careRotation=StrUtil.n2b((String)pset.getParameter("careRotation"));
		if(StringUtils.isNotEmpty(careRotation)){
			sql.append("   AND A.CARE_ROTATION > 0                     								\n");
		}
		String gloryroom=StrUtil.n2b((String)pset.getParameter("gloryroom"));
		if(StringUtils.isNotEmpty(gloryroom)){
			sql.append("   AND B.GLORYROOM > 0                     									\n");
		}
		String carePeople=StrUtil.n2b((String)pset.getParameter("carePeople"));
		if(StringUtils.isNotEmpty(carePeople)){
			sql.append("   AND A.CARE_PEOPLE > 0                     								\n");
		}
		
		sql.append(" order by A.DOMICILE_CODE                     									\n");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);		
		ds=executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		return RecordToBeanUtil.uppercaseToLowercase(ds); 
	}	
	/**
	 * @Title: getDsStart 
	 * @Description: excel分页信息A 
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
	 * @Description: excel分页信息B 
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
}
