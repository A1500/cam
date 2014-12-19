package com.inspur.sdmz.comm.query.knhQuery.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.sdmz.comm.util.BspUtil;

@SuppressWarnings("unchecked")
public class KnhQueryDao extends BaseJdbcDao {

	public DataSet knhQuery(ParameterSet pset) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String hzxm = (String) pset.getParameter("hzxmquery");
		String sfzh = (String) pset.getParameter("sfzhquery");
		String dz_zhen = (String) pset.getParameter("dzZhenquery");
		String dz_cun = (String) pset.getParameter("dzCunquery");
		String shbz = (String) pset.getParameter("shbzquery");
		String dz_qu = (String) pset.getParameter("quQuery");
		String szlx = (String) pset.getParameter("jzlxquery");
		String jtdz = (String) pset.getParameter("jtdzquery");//按地址排序
		String sm = (String) pset.getParameter("smquery");// 查询条目数
		String direct = (String) pset.getParameter("direct");// 排序
		String orderQ = (String) pset.getParameter("orderQ");//排名起 
		String orderZ = (String) pset.getParameter("orderZ");//排名止 
		String  organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT TT.* FROM ( ");
		sql.append("SELECT T.*, ROWNUM RN FROM ( ");
		sql.append(" SELECT a.* FROM AQUILA_TEST a WHERE 1=1 ");

		if (hzxm != null && !"".equals(hzxm)) {
			sql.append(" AND a.HZXM= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(hzxm);
		}
		if (sfzh != null && !"".equals(sfzh)) {
			sql.append(" AND a.SFZH= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sfzh);
		}
		if (dz_zhen != null && !"".equals(dz_zhen)) {
			sql.append(" AND a.DZ_ZHEN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dz_zhen);
		}
		if (dz_cun != null && !"".equals(dz_cun)) {
			sql.append(" AND a.DZ_CUN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dz_cun);
		}
		if (dz_qu != null && !"".equals(dz_qu)) {
			sql.append(" AND a.DZ_ZHEN  LIKE ?||'%'");
			dz_qu=dz_qu.substring(0, 6);
			typeList.add(Types.VARCHAR);
			argsList.add(dz_qu);
		}
		if (shbz != null && !"".equals(shbz)) {
			sql.append(" AND a.CHECK_FLAG= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(shbz);
		}
	
		if(szlx!=null && !"".equals(szlx)) {
			String[] szlxArr = szlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						sql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						sql.append(" INSTR(a.JZLX,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						sql.append(" AND INSTR(a.JZLX,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				sql.append(")");
			}
		}
		
		//查询阶段过滤条件
		String createOrgan="";
		if(organCode.substring(2,12).equals("0000000000")){
			createOrgan=organCode.substring(0,2);
		}else if(organCode.substring(4,12).equals("00000000")){
			createOrgan=organCode.substring(0,4);
		}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
			createOrgan=organCode.substring(0,6);
		}else if(organCode.substring(9,12).equals("000")){
			createOrgan=organCode.substring(0,9);
		}else  {
			createOrgan=organCode;
		}
		sql.append(" and a.LRDWQH LIKE ?||'%'");
		typeList.add(Types.VARCHAR);
		argsList.add(createOrgan);
		sql.append(" order by ");
		if (jtdz != null && !"".equals(jtdz)) {
			sql.append(" a.JTDZ asc ,");
		}
		sql.append(" a.JZZS_ZH ").append(direct);
		if (orderZ != null && !"".equals(orderZ)) {
			sql.append(") T WHERE ROWNUM <=" + orderZ);						
		}else{
			if (sm != null && !"".equals(sm)) {
				sql.append(") T WHERE ROWNUM <=" + sm);
			} else {
				sql.append(") T WHERE ROWNUM > 0");
			}
		}
		if (orderQ != null && !"".equals(orderQ)) {
			sql.append(") TT WHERE RN >=" + orderQ);	
		}else{
			sql.append(") TT WHERE RN >0");			
		}	
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(),types,args,getDsStart(pset),getDsLimit(pset),true);
		}else{
			resultDs = this.executeDataset(sql.toString(),getDsStart(pset),getDsLimit(pset),true);
		}
		return resultDs;
	}
	
	public DataSet recentQuery(ParameterSet pset) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String  organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		StringBuffer sb = new StringBuffer();
		sb.append("select BASEINFO_FAMILY.FAMILY_ID AS FAMILY_ID,");
		sb.append("   BASEINFO_FAMILY.FAMILY_NAME AS FAMILY_NAME,");
		sb.append("   totalname(BASEINFO_FAMILY.FAMILY_ID) MEMBER_NAME,");
		sb.append("   FUN(COUNTY) ||");
		sb.append("   CASE when (FUN(BASEINFO_FAMILY.COUNTY) is null) THEN  '' ELSE  '>' END");
		sb.append("   || FUN(TOWN) ||");
		sb.append("   CASE WHEN FUN(BASEINFO_FAMILY.TOWN) is null THEN '' ELSE  '>'  END");
		sb.append("   || FUN(BASEINFO_FAMILY.VILLAGE) AS ADDRESS,");
		sb.append("   BASEINFO_FAMILY.ASSISTANCE_TYPE AS ASSISTANCE_TYPE,");
		sb.append("   BASEINFO_FAMILY.CHECK_FLAG AS CHECK_FLAG,");
		sb.append("   BASEINFO_FAMILY.REG_TIME AS REG_TIME,");
		sb.append("   BASEINFO_FAMILY.FAMILY_CARD_NO AS FAMILY_CARD_NO,");
		sb.append("   SAM_INDEX.COMPOSITE_INDEX AS COMPOSITE_INDEX");
		sb.append(" from BASEINFO_FAMILY,SAM_INDEX ");
		sb.append(" WHERE BASEINFO_FAMILY.FAMILY_ID=SAM_INDEX.FAMILY_ID(+) ");
	
		String hzxm = (String) pset.getParameter("hzxmquery");
		if(hzxm!=null && !"".equals(hzxm)) {
			sb.append(" AND BASEINFO_FAMILY.FAMILY_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(hzxm);
		}
		String sfzh = (String) pset.getParameter("sfzhquery");
		if(sfzh!=null && !"".equals(sfzh)) {
			sb.append(" AND BASEINFO_FAMILY.FAMILY_CARD_NO= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sfzh);
		}
		String dz_zhen = (String) pset.getParameter("dzZhenquery");
		if(dz_zhen!=null && !"".equals(dz_zhen)) {
			sb.append(" AND BASEINFO_FAMILY.TOWN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dz_zhen);
		}
		String dz_cun = (String) pset.getParameter("dzCunquery");
		if(dz_cun!=null && !"".equals(dz_cun)) {
			sb.append(" AND BASEINFO_FAMILY.VILLAGE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dz_cun);
		}
		String shbz = (String) pset.getParameter("shbzquery");
		if(shbz!=null && !"".equals(shbz)) {
			sb.append(" AND BASEINFO_FAMILY.CHECK_FLAG= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(shbz);
		}
		String dz_qu = (String) pset.getParameter("quQuery");
		if(dz_qu!=null && !"".equals(dz_qu)) {
			sb.append(" AND BASEINFO_FAMILY.TOWN  LIKE ?||'%'");
			dz_qu=dz_qu.substring(0, 6);
			typeList.add(Types.VARCHAR);
			argsList.add(dz_qu);
		}
		String szlx = (String) pset.getParameter("jzlxquery");
		if(szlx!=null && !"".equals(szlx)) {
			String[] szlxArr = szlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						sb.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						sb.append(" INSTR(ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						sb.append(" AND INSTR(ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				sb.append(")");
			}
		}
		String lrsj = (String) pset.getParameter("lrsjquery");
		if(lrsj!=null && !"".equals(lrsj)) {
			sb.append(" AND BASEINFO_FAMILY.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(lrsj);
		}
		
		//查询阶段过滤条件
				String createOrgan="";
				 if(organCode.substring(2,12).equals("0000000000")){
						createOrgan=organCode.substring(0,2);
					}else if(organCode.substring(4,12).equals("00000000")){
						createOrgan=organCode.substring(0,4);
					}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
						createOrgan=organCode.substring(0,6);
					}else if(organCode.substring(9,12).equals("000")){
						createOrgan=organCode.substring(0,9);
					}else  {
						createOrgan=organCode;
					}
				 sb.append(" and BASEINFO_FAMILY.REG_ORG_AREA LIKE ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
				 if(typeList.size()!=0&&argsList.size()!=0){
						int[] types = new int[typeList.size()];
						for(int i=0;i<typeList.size();i++){
							types[i] = (Integer)typeList.get(i);
						}
						Object[] args = argsList.toArray(new Object[argsList.size()]);
						resultDs = this.executeDataset(sb.toString(),types,args,getDsStart(pset),getDsLimit(pset),true);
					}else{
						resultDs = this.executeDataset(sb.toString(),getDsStart(pset),getDsLimit(pset),true);
					}
					return resultDs;
			}
	
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
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
	@Override
	protected void initDao() {
		
	}
	public DataSet getJtxxNum(ParameterSet pset) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String hzxm = (String) pset.getParameter("hzxmquery");
		String sfzh = (String) pset.getParameter("sfzhquery");
		String dz_zhen = (String) pset.getParameter("dzZhenquery");
		String dz_cun = (String) pset.getParameter("dzCunquery");
		String shbz = (String) pset.getParameter("shbzquery");
		String dz_qu = (String) pset.getParameter("quQuery");
		String szlx = (String) pset.getParameter("jzlxquery");
		String sm = (String) pset.getParameter("smquery");// 查询条目数
		String direct = (String) pset.getParameter("direct");// 排序
		String orderQ = (String) pset.getParameter("orderQ");//排名起 
		String orderZ = (String) pset.getParameter("orderZ");//排名止 
		String  organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		StringBuffer sql = new StringBuffer();
		sql.append(" select  count(*) as HSNUM,decode(sum(TT.RK_SL),'',0,sum(TT.RK_SL)) RSNUM  from (");
		sql.append("SELECT T.*, ROWNUM RN FROM ( ");
		sql.append(" SELECT a.* FROM AQUILA_TEST a WHERE 1=1 ");
	
		if (hzxm != null && !"".equals(hzxm)) {
			sql.append(" AND a.HZXM= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(hzxm);
		}
		if (sfzh != null && !"".equals(sfzh)) {
			sql.append(" AND a.SFZH= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sfzh);
		}
		if (dz_zhen != null && !"".equals(dz_zhen)) {
			sql.append(" AND a.DZ_ZHEN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dz_zhen);
		}
		if (dz_cun != null && !"".equals(dz_cun)) {
			sql.append(" AND a.DZ_CUN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dz_cun);
		}
		if (dz_qu != null && !"".equals(dz_qu)) {
			sql.append(" AND a.DZ_ZHEN  LIKE ?||'%'");
			dz_qu=dz_qu.substring(0, 6);
			typeList.add(Types.VARCHAR);
			argsList.add(dz_qu);
		}
		if (shbz != null && !"".equals(shbz)) {
			sql.append(" AND a.CHECK_FLAG= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(shbz);
		}
		if(szlx!=null && !"".equals(szlx)) {
			String[] szlxArr = szlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						sql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						sql.append(" INSTR(a.JZLX,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						sql.append(" AND INSTR(a.JZLX,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				sql.append(")");
			}
		}
		
		//查询阶段过滤条件
		String createOrgan="";
		if(organCode.substring(2,12).equals("0000000000")){
			createOrgan=organCode.substring(0,2);
		}else if(organCode.substring(4,12).equals("00000000")){
			createOrgan=organCode.substring(0,4);
		}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
			createOrgan=organCode.substring(0,6);
		}else if(organCode.substring(9,12).equals("000")){
			createOrgan=organCode.substring(0,9);
		}else  {
			createOrgan=organCode;
		}
		sql.append(" and a.LRDWQH LIKE ?||'%'");
		typeList.add(Types.VARCHAR);
		argsList.add(createOrgan);
		sql.append(" order by a.JZZS_ZH ").append(direct);
		if (orderZ != null && !"".equals(orderZ)) {
			sql.append(") T WHERE ROWNUM <=" + orderZ);						
		}else{
			if (sm != null && !"".equals(sm)) {
				sql.append(") T WHERE ROWNUM <=" + sm);
			} else {
				sql.append(") T WHERE ROWNUM > 0");
			}
		}
		if (orderQ != null && !"".equals(orderQ)) {
			sql.append(") TT WHERE RN >=" + orderQ);	
		}else{
			sql.append(") TT WHERE RN >0");			
		}	
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(),types,args,true);
		}else{
			resultDs = this.executeDataset(sql.toString(),true);
		}
		return resultDs;
	}
}
