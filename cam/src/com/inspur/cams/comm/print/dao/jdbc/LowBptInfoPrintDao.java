package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * @title:AssDisabilityAppPrintDao
 * @description:伤残模块相关打印
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 public class LowBptInfoPrintDao extends IPrintDao{
	 ToDate todate = new ToDate();
	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}
	/**
	* @Title: queyLowBptInfo
	* @Description: 查询低保优抚对象信息
	* @return DataSet  
	* @throws
	* @author 
	 */
	public DataSet queryLowBptInfo(ParameterSet pset){
		String name = (String) pset.getParameter("nameprint");
		String idcard = (String) pset.getParameter("idcardprint");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();

		DataSet bptds = new DataSet();

		StringBuffer bptsql = new StringBuffer("");

		bptsql.append("select b.name ,b.id_card,n.name as nation,b.address, \n");
		bptsql.append("    (case b.sex when '1' then '男' when '2' then '女' end) sex, \n"); 
		bptsql.append("    dis.approve_date as disdate,sc.disenddate,base.disflag, \n"); 
		bptsql.append("    dep.approval_date as depdate,ss.dependdate,base.depflag, \n"); 
		bptsql.append("    demo.approval_date as demodate,zx.demoenddate,base.demoflag, \n"); 
		bptsql.append("    demoill.approval_date as demoilldate,db.demoillenddate,base.demoillflag, \n"); 
		bptsql.append("    war.approval_date as wardate,cz.warenddate,base.warflag, \n"); 
		bptsql.append("    tested.approval_date as testdate,cs.testenddate,base.testflag, \n"); 
		bptsql.append("    sold.approval_date as retdate,ll.retenddate,base.retflag, \n"); 
		bptsql.append("    mar.approval_date as mardate,ls.marenddate,base.marflag from \n"); 
		bptsql.append(" \n"); 
		bptsql.append("    bpt_people_disability dis, bpt_people_dependant dep ,bpt_people_demobilized demo , \n"); 
		bptsql.append("    bpt_people_demobilized_illness demoill ,bpt_people_war war, \n"); 
		bptsql.append("    bpt_people_tested tested, bpt_people_retired_soldier sold,bpt_people_martyr_offspring mar, \n"); 
		bptsql.append(" \n"); 
		bptsql.append("   (select c.allowance_month as disenddate ,d.people_id \n"); 
		bptsql.append("    from bpt_people_disability d ,bpt_state_change c where d.people_id = c.people_id and substr(c.object_type,0,1)='1') sc, \n"); 
		bptsql.append("   (select c.allowance_month as dependdate,d.people_id \n"); 
		bptsql.append("    from bpt_people_dependant d ,bpt_state_change c where d.people_id=c.people_id and substr(c.object_type,0,1)='2') ss, \n"); 
		bptsql.append("   (select c.allowance_month as demoenddate,d.people_id \n"); 
		bptsql.append("    from bpt_people_demobilized d ,bpt_state_change c where d.people_id=c.people_id and c.object_type='41') zx, \n"); 
		bptsql.append("   (select c.allowance_month as demoillenddate,d.people_id \n"); 
		bptsql.append("    from bpt_people_demobilized_illness d ,bpt_state_change c where d.people_id=c.people_id and  c.object_type='42') db, \n"); 
		bptsql.append("   ( select c.allowance_month as warenddate,d.people_id \n"); 
		bptsql.append("    from bpt_people_war d ,bpt_state_change c where d.people_id=c.people_id and  c.object_type='51') cz, \n"); 
		bptsql.append("    ( select c.allowance_month as testenddate,d.people_id \n"); 
		bptsql.append("    from bpt_people_tested d ,bpt_state_change c where d.people_id=c.people_id and  c.object_type='61') cs, \n"); 
		bptsql.append("     ( select c.allowance_month as retenddate,d.people_id \n"); 
		bptsql.append("    from bpt_people_retired_soldier d ,bpt_state_change c where d.people_id=c.people_id and  c.object_type='81') ll, \n"); 
		bptsql.append("     ( select c.allowance_month as marenddate,d.people_id \n"); 
		bptsql.append("    from bpt_people_martyr_offspring d ,bpt_state_change c where d.people_id=c.people_id and  c.object_type='B1') ls, \n"); 
		bptsql.append("   ( select \n"); 
		bptsql.append("         (case when p.disability_flag='1' then '√' else '  ' end ) as disflag, \n"); 
		bptsql.append("         (case when p.dependant_flag='1'  then '√' else '  ' end ) as depflag, \n"); 
		bptsql.append("         (case when p.demobilized_flag='1' and d.demobilized_tyep_code='41' then '√' else '  ' end ) as demoflag, \n"); 
		bptsql.append("         (case when p.demobilized_flag='1' and d.demobilized_tyep_code='42' then '√' else '  ' end ) as demoillflag, \n"); 
		bptsql.append("         (case when p.war_flag='1' and d.war_type_code='51' then '√' else '  ' end ) as warflag, \n"); 
		bptsql.append("         (case when p.war_flag='1' and d.war_type_code='61' then '√' else '  ' end ) as testflag, \n"); 
		bptsql.append("         (case when p.martyr_offspring_flag='1' then '√' else '  ' end ) as marflag, \n"); 
		bptsql.append("         (case when p.retired_flag='1' then '√' else '  ' end ) as retflag,  d.people_id \n"); 
		bptsql.append("     from  baseinfo_people p ,bpt_people d where p.people_id=d.people_id ) base,baseinfo_people b,dic_nation n \n"); 
		bptsql.append("     where b.people_id=sc.people_id(+) and b.people_id = ss.people_id(+) and b.people_id = zx.people_id(+) and b.nation=n.code \n"); 
		bptsql.append("     and b.people_id = db.people_id(+) and b.people_id = cz.people_id(+) and b.people_id = cs.people_id(+) \n"); 
		bptsql.append("     and b.people_id = ll.people_id(+) and b.people_id = ls.people_id(+) and b.people_id=base.people_id(+) \n"); 
		bptsql.append("     and b.people_id = dis.people_id(+) and b.people_id = dep.people_id(+) and b.people_id = demo.people_id(+) \n"); 
		bptsql.append("     and b.people_id = demoill.people_id(+) and b.people_id = war.people_id(+) and b.people_id = tested.people_id(+) \n"); 
		bptsql.append("     and b.people_id = mar.people_id(+) and b.people_id = sold.people_id(+)");


		
		if (StringUtils.isNotEmpty(name)) {
			bptsql.append(" and b.name=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(name);
		}
		if (StringUtils.isNotEmpty(idcard)) {
			bptsql.append(" and b.id_card=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(idcard);
		}
		
		
		
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			bptds = this.executeDataset(bptsql.toString(), types, args, true);
		} else {
			bptds = this.executeDataset(bptsql.toString(), true);
		}
		
		DataSet lowds = new DataSet();
		typeList = new ArrayList<Integer>();
		objsList = new ArrayList<String>();
		StringBuffer lowsql = new StringBuffer("");

		lowsql.append("select (case t.assistance_type when  '01' then '√'  else '  ' end)  as csflag, \n");
		lowsql.append("       (case t.assistance_type when  '02' then '√'   else '  ' end) as ncflag, \n"); 
		lowsql.append("       (case t.assistance_type when  '03' then '√'  else '  '  end) as wbflag, \n"); 
		lowsql.append("       t.BEGIN_DATE,s.name,s.id_card ,n.name as nation ,s.address , \n"); 
		lowsql.append("            (case s.sex when '1' then '男' when '2' then '女' end) sex, \n"); 
		lowsql.append("            (case t.end_date when '3000-12' then '' else t.end_date end) end_date \n"); 
		lowsql.append("       from SAM_FAMILY_TREATMENT t ,BASEINFO_FAMILY_ARCHIVE p,BASEINFO_PEOPLE_ARCHIVE s  ,dic_nation n \n"); 
		lowsql.append("        where t.family_id=p.family_id and t.apply_id=p.apply_id and s.family_archive_id=p.family_archive_id  and s.nation=n.code");

		if (StringUtils.isNotEmpty(name)) {
			lowsql.append(" and s.name=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(name);
		}
		if (StringUtils.isNotEmpty(idcard)) {
			lowsql.append(" and s.id_card=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(idcard);
		}
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			lowds = this.executeDataset(lowsql.toString(), types, args, true);
		} else {
			lowds = this.executeDataset(lowsql.toString(), true);
		}
		
		
		
		DataSet ds = new DataSet();
		if(lowds.getCount()>0){
			
			if(bptds.getCount()>0){
				lowds.addField("DISDATE");
		        lowds.addField("DISENDDATE");
		        lowds.addField("DEPFLAG");
		        lowds.addField("DEPDATE");
		        lowds.addField("DEPENDDATE");
		        lowds.addField("DISFLAG");
		        lowds.addField("DEMODATE");
		        lowds.addField("DEMOENDDATE");
		        lowds.addField("DEMOFLAG");
		        lowds.addField("DEMOFLAG");
		        lowds.addField("DEMOILLEDDDATE");
		        lowds.addField("DEMOILLFLAG");
		        lowds.addField("WARDATE");
		        lowds.addField("WARENDDATE");
		        lowds.addField("WARFLAG");
		        lowds.addField("TESTDATE");
		        lowds.addField("TESTENDDATE");
				lowds.addField("TESTFLAG");
				lowds.addField("RETDATE");
				lowds.addField("RETENDDATE");
				lowds.addField("RETFLAG");
				lowds.addField("MARDATE");
				lowds.addField("MARENDDATE");
				lowds.addField("MARFLAG");
				if(!"".equals((String)bptds.getRecord(0).get("NAME"))){
					lowds.getRecord(0).set("NAME",(String)bptds.getRecord(0).get("NAME"));
				}
				if(!"".equals((String)bptds.getRecord(0).get("ID_CARD"))){
					lowds.getRecord(0).set("ID_CARD",(String)bptds.getRecord(0).get("ID_CARD"));
				}
				if(!"".equals((String)bptds.getRecord(0).get("NATION"))){
					lowds.getRecord(0).set("NATION",(String)bptds.getRecord(0).get("NATION"));
				}
				if(!"".equals((String)bptds.getRecord(0).get("ADDRESS"))){
					lowds.getRecord(0).set("ADDRESS",(String)bptds.getRecord(0).get("ADDRESS"));
				}
				if(!"".equals((String)bptds.getRecord(0).get("SEX"))){
					lowds.getRecord(0).set("SEX",(String)bptds.getRecord(0).get("SEX"));
				}
				lowds.getRecord(0).set("DISDATE",(String)bptds.getRecord(0).get("DISDATE"));
				lowds.getRecord(0).set("DISENDDATE",(String)bptds.getRecord(0).get("DISENDDATE"));
				lowds.getRecord(0).set("DEPFLAG",(String)bptds.getRecord(0).get("DEPFLAG"));
				lowds.getRecord(0).set("DEPDATE",(String)bptds.getRecord(0).get("DEPDATE"));
				lowds.getRecord(0).set("DEPENDDATE",(String)bptds.getRecord(0).get("DEPENDDATE"));
				lowds.getRecord(0).set("DISFLAG",(String)bptds.getRecord(0).get("DISFLAG"));
				lowds.getRecord(0).set("DEMODATE",(String)bptds.getRecord(0).get("DEMODATE"));
				lowds.getRecord(0).set("DEMOENDDATE",(String)bptds.getRecord(0).get("DEMOENDDATE"));
				lowds.getRecord(0).set("DEMOFLAG",(String)bptds.getRecord(0).get("DEMOFLAG"));
				lowds.getRecord(0).set("DEMOILLFLAG",(String)bptds.getRecord(0).get("DEMOFLAG"));
				lowds.getRecord(0).set("DEMOILLEDDDATE",(String)bptds.getRecord(0).get("DEMOILLEDDDATE"));
				lowds.getRecord(0).set("DEMOILLFLAG",(String)bptds.getRecord(0).get("DEMOILLFLAG"));
				lowds.getRecord(0).set("WARDATE",(String)bptds.getRecord(0).get("WARDATE"));
				lowds.getRecord(0).set("WARENDDATE",(String)bptds.getRecord(0).get("WARENDDATE"));
				lowds.getRecord(0).set("WARFLAG",(String)bptds.getRecord(0).get("WARFLAG"));
				lowds.getRecord(0).set("TESTDATE",(String)bptds.getRecord(0).get("TESTDATE"));
				lowds.getRecord(0).set("TESTENDDATE",(String)bptds.getRecord(0).get("TESTENDDATE"));
				lowds.getRecord(0).set("TESTFLAG",(String)bptds.getRecord(0).get("TESTFLAG"));
				lowds.getRecord(0).set("RETDATE",(String)bptds.getRecord(0).get("RETDATE"));
				lowds.getRecord(0).set("RETENDDATE",(String)bptds.getRecord(0).get("RETENDDATE"));
				lowds.getRecord(0).set("RETFLAG",(String)bptds.getRecord(0).get("RETFLAG"));
				lowds.getRecord(0).set("MARDATE",(String)bptds.getRecord(0).get("MARDATE"));
				lowds.getRecord(0).set("MARENDDATE",(String)bptds.getRecord(0).get("MARENDDATE"));
				lowds.getRecord(0).set("MARFLAG",(String)bptds.getRecord(0).get("MARFLAG"));
			}
			return lowds;
		}
		
		
		if(bptds.getCount()>0){
			if(lowds.getCount()>0){
				bptds.addField("CSFLAG");
				bptds.addField("NCFLAG");
				bptds.addField("WBFLAG");
				bptds.addField("BEGIN_DATE");
				bptds.addField("END_DATE");
				bptds.getRecord(0).set("CSFLAG",(String)lowds.getRecord(0).get("CSFLAG"));
				bptds.getRecord(0).set("NCFLAG",(String)lowds.getRecord(0).get("NCFLAG"));
				bptds.getRecord(0).set("WBFLAG",(String)lowds.getRecord(0).get("WBFLAG"));
				bptds.getRecord(0).set("BEGIN_DATE",(String)lowds.getRecord(0).get("BEGIN_DATE"));
				bptds.getRecord(0).set("END_DATE",(String)lowds.getRecord(0).get("END_DATE"));
				bptds.getRecord(0).set("NAME",(String)lowds.getRecord(0).get("NAME"));
				bptds.getRecord(0).set("ID_CARD",(String)lowds.getRecord(0).get("ID_CARD"));
				bptds.getRecord(0).set("SEX",(String)lowds.getRecord(0).get("SEX"));
				bptds.getRecord(0).set("NATION",(String)lowds.getRecord(0).get("NATION"));
				bptds.getRecord(0).set("ADDRESS",(String)lowds.getRecord(0).get("ADDRESS"));
			}
			return bptds;
		}
		return ds;
	}
	@Override
	public DataSet queryData(ParameterSet pset) {
		// TODO 自动生成的方法存根
		return null;
	}
}
