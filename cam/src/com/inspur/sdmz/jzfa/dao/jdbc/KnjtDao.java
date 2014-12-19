package com.inspur.sdmz.jzfa.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.sdmz.comm.util.BspUtil;

@SuppressWarnings("unchecked")
public class KnjtDao extends BaseJdbcDao {

	public DataSet query(ParameterSet pset) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		String hzxm = (String) pset.getParameter("hzxmquery");// 户主姓名
		String sfzh = (String) pset.getParameter("sfzhquery");// 身份证号
		String dz_zhen = (String) pset.getParameter("dzZhenquery");// 街道
		String dz_cun = (String) pset.getParameter("dzCunquery");// 村居
		String dz_qu = (String) pset.getParameter("quQuery");// 区查询
		String shbz = (String) pset.getParameter("shbzquery");// 审核状态
		String szlx = (String) pset.getParameter("jzlxquery");// 受助类型
		String jtdz = (String) pset.getParameter("jtdzquery");//按地址排序
		String sm = (String) pset.getParameter("smquery");// 查询条目数
		String direct = (String) pset.getParameter("direct");// 排序
		String orderQ = (String) pset.getParameter("orderQ");//排名起 
		String orderZ = (String) pset.getParameter("orderZ");//排名止 
		
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

		if (szlx != null && !"".equals(szlx)) {
			String[] szlxArr = szlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if (!"".equals(szlxArr[i])) {
					if (!andFlag) {
						sql.append(" AND (");
					}
					andFlag = true;
					if (!orFlag) {
						sql.append(" INSTR(a.JZLX,'" + szlxArr[i] + "',1)!=0");
						orFlag = true;
					} else {
						sql.append(" AND INSTR(a.JZLX,'" + szlxArr[i]
								+ "',1)!=0");
					}
				}
			}
			if (andFlag) {
				sql.append(")");
			}
		}

		// 数据权限过滤--上级能查看下级，下级不能查看上级
		String createOrgan = "";
		if (organCode.substring(2, 12).equals("0000000000")) {
			createOrgan = organCode.substring(0, 2);
		} else if (organCode.substring(4, 12).equals("00000000")) {
			createOrgan = organCode.substring(0, 4);
		} else if (organCode.substring(6, 12).equals("000000")
				|| organCode.substring(6, 12) == "000000") {
			createOrgan = organCode.substring(0, 6);
		} else if (organCode.substring(9, 12).equals("000")) {
			createOrgan = organCode.substring(0, 9);
		} else {
			createOrgan = organCode;
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

	private int getDsStart(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageStart();
		}
		int start = 0;
		if ("0".equals(excelType)) { // 导出当前页
			Integer startExcel = (java.lang.Integer) pset
					.getParameter("startExcel");
			if (startExcel != null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}

	private int getDsLimit(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel"))
				.intValue();
		return limit > 1000 ? 1000 : limit;
	}

	@Override
	protected void initDao() {

	}

	public DataSet getJtxxNum(ParameterSet pset) {
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String organCode = (String) pset.getParameter("organCode");
		String hzxm = (String) pset.getParameter("hzxmquery");// 户主姓名
		String sfzh = (String) pset.getParameter("sfzhquery");// 身份证号
		String dz_zhen = (String) pset.getParameter("dzZhenquery");// 街道
		String dz_cun = (String) pset.getParameter("dzCunquery");// 村居
		String dz_qu = (String) pset.getParameter("quQuery");// 区查询
		String shbz = (String) pset.getParameter("shbzquery");// 审核状态
		String szlx = (String) pset.getParameter("jzlxquery");// 受助类型
		String sm = (String) pset.getParameter("smquery");// 查询条目数
		String direct = (String) pset.getParameter("direct");// 排序
		String orderQ = (String) pset.getParameter("orderQ");//排名起 
		String orderZ = (String) pset.getParameter("orderZ");//排名止 
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT count(*) as HSNUM,decode(sum(TT.RK_SL), '', 0, sum(TT.RK_SL)) RSNUM from ( ");
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

		if (szlx != null && !"".equals(szlx)) {
			String[] szlxArr = szlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if (!"".equals(szlxArr[i])) {
					if (!andFlag) {
						sql.append(" AND (");
					}
					andFlag = true;
					if (!orFlag) {
						sql.append(" INSTR(a.JZLX,'" + szlxArr[i] + "',1)!=0");
						orFlag = true;
					} else {
						sql.append(" AND INSTR(a.JZLX,'" + szlxArr[i]
								+ "',1)!=0");
					}
				}
			}
			if (andFlag) {
				sql.append(")");
			}
		}

		// 数据权限过滤--上级能查看下级，下级不能查看上级
		String createOrgan = "";
		if (organCode.substring(2, 12).equals("0000000000")) {
			createOrgan = organCode.substring(0, 2);
		} else if (organCode.substring(4, 12).equals("00000000")) {
			createOrgan = organCode.substring(0, 4);
		} else if (organCode.substring(6, 12).equals("000000")
				|| organCode.substring(6, 12) == "000000") {
			createOrgan = organCode.substring(0, 6);
		} else if (organCode.substring(9, 12).equals("000")) {
			createOrgan = organCode.substring(0, 9);
		} else {
			createOrgan = organCode;
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
