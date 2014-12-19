package com.inspur.sdmz.jzzs.dao;



import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.sdmz.comm.util.BspUtil;

public class JzzsQueryDao extends BaseJdbcDao {

	@Override
	protected void initDao() {

	}
	public DataSet query(ParameterSet params) {
		StringBuffer jzzSql = new StringBuffer();
		jzzSql.append(" SELECT * FROM AQUILA_TEST a WHERE 1=1");

		String  organCode=BspUtil.getCorpOrgan().getOrganCode();
		String hzxm = (String) params.getParameter("HZXM");//户主姓名
		String sfzh = (String) params.getParameter("SFZH");//身份证号
		String dzZhen = (String) params.getParameter("DZZHEN");//街道
		String dzCun  = (String) params.getParameter("DZCUN");//村居
		String jzlx   = (String) params.getParameter("JZLX");//受助类型
		String houseQuality = (String) params.getParameter("HOUSE_QUALITY");//住房类型
		String houseStatus = (String) params.getParameter("HOUSE_STATUS");//房屋状况
		String buildingStructure = (String) params.getParameter("BUILDING_STRUCTURE");//住房结构
		String sgzl   = (String) params.getParameter("SGZL");//事故种类
		String sgss   = (String) params.getParameter("SGSS");//事故损失
		String jyzk   = (String) params.getParameter("JYZK");//教育阶段
		String zhzl   = (String) params.getParameter("ZHZL");//灾害种类
		String zhssje = (String) params.getParameter("ZHSSJE");//灾害损失
		String cjlx   = (String) params.getParameter("CJLX");//残疾种类
		String cjdj   = (String) params.getParameter("CJDJ");//残疾等级
		String hbzl   = (String) params.getParameter("HBZL");//患病种类
		String ylzc   = (String) params.getParameter("YLZC");//医疗支出
		String sylv   = (String) params.getParameter("SYLV");//失业率
		String ylnl   = (String) params.getParameter("YLNL");//老人年龄
		String jzfx   = (String) params.getParameter("JZFX");//救助方向
		String dzqu   = (String) params.getParameter("DZQU");//区查询


		//数据权限过滤--上级能查看下级，下级不能查看上级
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
		 jzzSql.append(" and a.LRDWQH LIKE '").append(createOrgan).append("%'");
		//查询条件
		if (dzZhen != null && !dzZhen.equals("")) {//镇查询
			jzzSql.append(" and a.DZ_ZHEN= '").append(dzZhen).append("'");
		}
		if (dzqu != null && !dzqu.equals("")) {//镇查询
			jzzSql.append(" and a.DZ_ZHEN LIKE '").append(dzqu.substring(0, 6)).append("%'");
		}
		if (dzCun != null && !dzCun.equals("")) {//村查询
			jzzSql.append(" and a.DZ_CUN= '").append(dzCun).append("'");
		}
		if (jzlx != null && !jzlx.equals("")) {//救助类型
			String[] szlxArr = jzlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						jzzSql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						jzzSql.append(" INSTR(a.JZLX,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						jzzSql.append(" and INSTR(a.JZLX,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				jzzSql.append(")");
			}
		}
		if (hzxm != null && !hzxm.equals("")) {//户主姓名
			jzzSql.append(" and a.HZXM= '").append(hzxm).append("'");
		}
		if (sfzh != null && !sfzh.equals("")) {//身份证号
			jzzSql.append(" and a.SFZH= '").append(sfzh).append("'");
		}
		if (houseQuality != null && !houseQuality.equals("")) {//住房类型
			jzzSql.append(" and a.HOUSE_QUALITY= '").append(houseQuality).append("'");
		}
		if (houseStatus != null && !houseStatus.equals("")) {//房屋状况
			jzzSql.append(" and a.ZFZKLXDM= '").append(houseStatus).append("'");
		}
		if (buildingStructure != null && !buildingStructure.equals("")) {//住房结构
			jzzSql.append(" and a.FWJGDM= '").append(buildingStructure).append("'");
		}
		if (sgzl != null && !sgzl.equals("")) {//事故种类
			jzzSql.append(" and a.SGXX LIKE '%").append(sgzl).append("%'");
		}
		if (sgss != null && !sgss.equals("")) {//事故损失
			jzzSql.append(" and a.jtid  in (select distinct b.FAMILY_ID from BASEINFO_PEOPLE b, SAM_PEOPLE_ACCIDENT c where b.PEOPLE_ID = c.PEOPLE_ID and c.LOSS_MON = '").append(sgss).append("')");
		}
		if (jyzk != null && !jyzk.equals("")) {//教育阶段
			jzzSql.append(" and a.JYXX LIKE '%").append(jyzk).append("%'");
		}
		if (zhzl != null && !zhzl.equals("")) {//灾害种类
			jzzSql.append(" and GETZRZH(a.jtid) LIKE '%").append(zhzl).append("%'");
		}
		if (zhssje != null && !zhssje.equals("")) {//灾害损失
			jzzSql.append(" and a.jtid  in (select distinct b.FAMILY_ID from BASEINFO_FAMILY b,SAM_FAMILY_CALAMITY c where b.FAMILY_ID=c.FAMILY_ID  and c.LOSS_MON='").append(zhssje).append("')");
		}
		if (cjlx != null && !cjlx.equals("")) {//残疾种类
			jzzSql.append(" and a.CJXX LIKE '%").append(cjlx).append("%'");
		}
		if (cjdj != null && !cjdj.equals("")) {//残疾等级
			jzzSql.append(" and a.jtid  in (select distinct b.FAMILY_ID from BASEINFO_PEOPLE b,SAM_PEOPLE_DISABILITY c where b.PEOPLE_ID = c.PEOPLE_ID  and c.DISABILITY_LEVEL='").append(cjdj).append("')");
		}
		if (hbzl != null && !hbzl.equals("")) {//患病种类
			jzzSql.append(" and a.HBXX LIKE '%").append(hbzl).append("%'");
		}
		if (ylzc != null && !ylzc.equals("")) {//医疗支出
			jzzSql.append(" and a.jtid  in (select distinct b.FAMILY_ID from BASEINFO_PEOPLE b, SAM_PEOPLE_DISEASE c where b.PEOPLE_ID = c.PEOPLE_ID and c.COST_MON = '").append(ylzc).append("')");
		}
		if (sylv != null && !sylv.equals("")) {//失业率
			jzzSql.append(" and GETJYLV(a.jtid) >= ").append(sylv).append(" ");
		}
		if (ylnl != null && !ylnl.equals("")) {//老人年龄
			jzzSql.append(" AND a.jtid in(select a.jtid   from  BASEINFO_FAMILY  where GETYLNL(a.jtid)>= ").append(ylnl).append(") ");
		}
		if (jzfx != null && !jzfx.equals("")) {

		    if(jzfx.equals("YL")){//医疗
			    jzzSql.append(" ORDER BY JZZS_YL DESC ");
			}else if(jzfx.equals("ZF")){//住房
			    jzzSql.append(" ORDER BY JZZS_ZF DESC ");
			}else if(jzfx.equals("SG")){//事故
			    jzzSql.append(" ORDER BY JZZS_SG DESC ");
			}else if(jzfx.equals("JY")){//教育
			    jzzSql.append(" ORDER BY JZZS_JY DESC ");
			}else if(jzfx.equals("LR")){//养老
				jzzSql.append(" ORDER BY JZZS_LN DESC ");
			}else if(jzfx.equals("ZH")){//自然灾害
				jzzSql.append(" ORDER BY JZZS_ZRZH DESC ");
			}else if(jzfx.equals("CJ")){//残疾
				jzzSql.append(" ORDER BY JZZS_CJ DESC ");
			}else if(jzfx.equals("SY")){//就业
				jzzSql.append(" ORDER BY JZZS_SY DESC ");
			}else if(jzfx.equals("DQ")){//单亲
				jzzSql.append(" ORDER BY JZZS_DQ DESC ");
			}
		}else  if (jzfx == null || jzfx.equals("")) {//
			jzzSql.append(" ORDER BY JZZS_ZH DESC ");
		}
        return executeDataset(jzzSql.toString(), getDsStart(params), getDsLimit(params), true);
	}
	/**
	 *
	 * @param pset
	 * @return
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
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
}
