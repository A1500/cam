package com.inspur.cams.welfare.prosthesis.query.dao.support;

import org.loushang.next.dao.EntityDao;
import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.inspur.cams.comm.util.StrUtil;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.welfare.base.data.WealFitStatus;
import com.inspur.cams.welfare.prosthesis.query.dao.IFitReportDao;
/**
 * @title:福利企业情况统计
 * @description:
 * @author: sunlei
 * @since:2013-12-26
 * @version:1.0
*/
@SuppressWarnings("unchecked")
public class FitReportDao extends EntityDao<WealFitStatus> implements IFitReportDao {
	@Override
	protected Class<WealFitStatus> getEntityClass() {
		return WealFitStatus.class;
	}
	public DataSet queryBaseinfoReport(ParameterSet pset){
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
		int index=12;
		int indexUp=9;
		if(StringUtils.isNotEmpty(domicileCode)){
			if(domicileCode.indexOf("000")<9&&domicileCode.indexOf("000")>0){
				index=getSubstrIndex(domicileCode);
				indexUp=getSubstrIndexInit(domicileCode);
			}
		}
		DataSet peods = new DataSet();
		StringBuffer peosql = new StringBuffer("");
		
		peosql.append("select b.fit_num,b.ECONOMIC_ONE,b.ECONOMIC_TWO,b.ECONOMIC_THREE,b.ECONOMIC_FOUR,b.ECONOMIC_FIVE,             ");
		peosql.append("		  b.ECONOMIC_SIX,b.workers_all,B.PRODUCTOR_NUM,B.PRODUCTOR_NOT_NUM,b.workers_deform,              ");
		peosql.append("		  b.CERT_ONE,b.CERT_TWO,B.CERT_THREE,b.reg_fund,b.id,b.name              ");
		peosql.append("		from (              ");
		
		peosql.append(" (select s.fit_num,s.ECONOMIC_ONE,s.ECONOMIC_TWO,s.ECONOMIC_THREE,s.ECONOMIC_FOUR,s.ECONOMIC_FIVE,             ");
		peosql.append("		  S.ECONOMIC_SIX,S.workers_all,S.PRODUCTOR_NUM,S.PRODUCTOR_NOT_NUM,S.workers_deform,              ");
		peosql.append("		  S.CERT_ONE,S.CERT_TWO,S.CERT_THREE,S.reg_fund,D.id,D.name              ");
		
		peosql.append("from dic_city d, (              ");
		peosql.append("      select rpad(substr(a.morg_area,1,"+indexUp+"),12,'0') domicile_code ,             ");
		peosql.append("      count(a.fit_id) fit_num,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='01' then  1  else   0  end) ECONOMIC_ONE,             ");
		peosql.append("      sum(case  when  a.economic_nature_code='02' then  1  else   0  end) ECONOMIC_TWO,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='03' then  1  else   0  end) ECONOMIC_THREE,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='04' then  1  else   0  end) ECONOMIC_FOUR,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='05' then  1  else   0  end) ECONOMIC_FIVE,             ");
		peosql.append("      sum(case  when  a.economic_nature_code<>'05' and a.economic_nature_code<>'04'               ");
		peosql.append("      	and a.economic_nature_code<>'03' and a.economic_nature_code<>'02'             ");
		peosql.append("      	and a.economic_nature_code<>'01' then  1  else   0  end) ECONOMIC_SIX,             ");
		
		peosql.append("      count(a.WORKER_ID) workers_all,              ");
		peosql.append("      sum(case when a.IF_PRODUCTOR = '1' then 1 else 0 end) PRODUCTOR_NUM,              ");
		peosql.append("      sum(case when a.IF_PRODUCTOR = '0' then 1 else 0 end) PRODUCTOR_NOT_NUM,              ");
		peosql.append("      sum(case when a.DISABILITY_TYPE is not null then 1 else 0 end) workers_deform,              ");
		peosql.append("      sum(case when a.CERT_SITUATION = '1' then 1 else 0 end) CERT_ONE,              ");
		peosql.append("      sum(case when a.CERT_SPECIAL_SITUATION = '1' then 1 else 0 end) CERT_TWO,              ");
		peosql.append("      sum(case when a.CERT_ORTHOSIS_SITUATION = '1' then 1 else 0 end) CERT_THREE,              ");
		peosql.append("      sum(a.reg_fund) reg_fund              ");
		
		peosql.append("      from (              ");
		peosql.append("            select t.morg_area,t.fit_id,t.economic_nature_code,t.reg_fund,s.task_code,w.worker_id,                        ");
		peosql.append("               w.if_productor, w.disability_type, w.cert_situation, w.cert_special_situation, w.cert_orthosis_situation         ");
		peosql.append("            from weal_fit_status t, weal_fit_info s,WEAL_WORKER w                         ");
		peosql.append("            where t.status = '1'                     					 ");
		peosql.append("            		 and s.task_code = w.task_code(+)                        ");
		peosql.append("            		 and t.task_code = s.task_code(+)                        ");
		peosql.append("           )a                    ");
		peosql.append("       group by rpad(substr(a.morg_area,1,"+indexUp+"),12,'0')         ");
		peosql.append("       )s                       ");               
		peosql.append(" where s.domicile_code(+) = d.id                           ");
		peosql.append("   and d.id = ?         )                                        ");
		typeList.add(Types.VARCHAR);
		argsList.add(domicileCode);
		
		
		peosql.append("   union                                        ");
		
		peosql.append(" (select s.fit_num,s.ECONOMIC_ONE,s.ECONOMIC_TWO,s.ECONOMIC_THREE,s.ECONOMIC_FOUR,s.ECONOMIC_FIVE,             ");
		peosql.append("		  S.ECONOMIC_SIX,S.workers_all,S.PRODUCTOR_NUM,S.PRODUCTOR_NOT_NUM,S.workers_deform,              ");
		peosql.append("		  S.CERT_ONE,S.CERT_TWO,S.CERT_THREE,S.reg_fund,D.id,D.name              ");
		
		peosql.append("from dic_city d, (              ");
		peosql.append("      select rpad(substr(a.morg_area,1,"+index+"),12,'0') domicile_code ,             ");
		peosql.append("      count(a.fit_id) fit_num,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='01' then  1  else   0  end) ECONOMIC_ONE,             ");
		peosql.append("      sum(case  when  a.economic_nature_code='02' then  1  else   0  end) ECONOMIC_TWO,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='03' then  1  else   0  end) ECONOMIC_THREE,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='04' then  1  else   0  end) ECONOMIC_FOUR,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='05' then  1  else   0  end) ECONOMIC_FIVE,             ");
		peosql.append("      sum(case  when  a.economic_nature_code<>'05' and a.economic_nature_code<>'04'               ");
		peosql.append("      	and a.economic_nature_code<>'03' and a.economic_nature_code<>'02'             ");
		peosql.append("      	and a.economic_nature_code<>'01' then  1  else   0  end) ECONOMIC_SIX,             ");
		
		peosql.append("      count(a.WORKER_ID) workers_all,              ");
		peosql.append("      sum(case when a.IF_PRODUCTOR = '1' then 1 else 0 end) PRODUCTOR_NUM,              ");
		peosql.append("      sum(case when a.IF_PRODUCTOR = '0' then 1 else 0 end) PRODUCTOR_NOT_NUM,              ");
		peosql.append("      sum(case when a.DISABILITY_TYPE is not null then 1 else 0 end) workers_deform,              ");
		peosql.append("      sum(case when a.CERT_SITUATION = '1' then 1 else 0 end) CERT_ONE,              ");
		peosql.append("      sum(case when a.CERT_SPECIAL_SITUATION = '1' then 1 else 0 end) CERT_TWO,              ");
		peosql.append("      sum(case when a.CERT_ORTHOSIS_SITUATION = '1' then 1 else 0 end) CERT_THREE,              ");
		peosql.append("      sum(a.reg_fund) reg_fund              ");
		
		peosql.append("      from (              ");
		peosql.append("            select t.morg_area,t.fit_id,t.economic_nature_code,t.reg_fund,s.task_code,w.worker_id,                        ");
		peosql.append("               w.if_productor, w.disability_type, w.cert_situation, w.cert_special_situation, w.cert_orthosis_situation         ");
		peosql.append("            from weal_fit_status t, weal_fit_info s,WEAL_WORKER w                         ");
		peosql.append("            where t.status = '1'                     					 ");
		peosql.append("            		 and s.task_code = w.task_code(+)                        ");
		peosql.append("            		 and t.task_code = s.task_code(+)                        ");
		peosql.append("           )a                    ");
		peosql.append("       group by rpad(substr(a.morg_area,1,"+index+"),12,'0')         ");
		peosql.append("       )s                       ");               
		peosql.append(" where s.domicile_code(+) = d.id                           ");
		peosql.append(" 	and d.id=rpad(substr(d.id, 1, "+index+"), 12, '0')          ");
		if(domicileCode.endsWith("000")){
			peosql.append("   and d.ups = ?      )                                           ");
		}else{
			peosql.append("   and d.id = ?       )                                           ");
		}	
		typeList.add(Types.VARCHAR);
		argsList.add(domicileCode);
		
		peosql.append("   ) b                                           ");
		
		peosql.append("	order by b.id                            ");  

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			peods = this.executeDataset(peosql.toString(), types, args, true);
		} else {
			peods = this.executeDataset(peosql.toString(), true);
		}
		peods.addField("SCALE_LIMB");
		for(int i = 0 ;i<peods.getCount();i++){
			Record re = peods.getRecord(i);
			String a = (re.get("WORKERS_ALL")!=null?re.get("WORKERS_ALL"):"0").toString();
			String b = (re.get("WORKERS_DEFORM")!=null?re.get("WORKERS_DEFORM"):"0").toString();
			float Fa=Float.parseFloat(a);
			float Fb=Float.parseFloat(b);
			if(Fa==0){
				float c=0;
				re.set("SCALE_LIMB",c);
			}else{
				float c=Fb/(Fa)*100;
				BigDecimal m=new BigDecimal(c);
				c=m.setScale(2,BigDecimal.ROUND_HALF_UP).floatValue();
				re.set("SCALE_LIMB",c);
			}
		}
		return peods;
	}
	//建设情况统计
	public DataSet queryBuildinfoReport(ParameterSet pset){
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
		int index=12;
		int indexUp=9;
		if(StringUtils.isNotEmpty(domicileCode)){
			if(domicileCode.indexOf("000")<9&&domicileCode.indexOf("000")>0){
				index=getSubstrIndex(domicileCode);
				indexUp=getSubstrIndexInit(domicileCode);
			}
		}
		DataSet peods = new DataSet();
		StringBuffer peosql = new StringBuffer("");
		
		peosql.append("select b.fit_num,b.OPERATE_AREA, b.PRODUCT_AREA, b.RECOVERY_AREA, b.RECEPTION_AREA,             ");
		peosql.append("		  b.TRAIN_AREA,  b.TREATMENT_AREA, b.WORK_AREA, b.LEISURE_AREA,  b.OTHER_AREA,b.id,b.name              ");
		peosql.append("		from (              ");
		
		peosql.append(" (select s.fit_num, s.OPERATE_AREA, s.PRODUCT_AREA, s.RECOVERY_AREA, s.RECEPTION_AREA,             ");
		peosql.append("		  s.TRAIN_AREA,  s.TREATMENT_AREA, s.WORK_AREA, s.LEISURE_AREA,  s.OTHER_AREA, d.id, d.name              ");
		
		peosql.append("from dic_city d, (              ");
		peosql.append("      select rpad(substr(a.morg_area,1,"+indexUp+"),12,'0') domicile_code ,             ");
		peosql.append("      		count(a.fit_id) fit_num,              											 ");
		peosql.append("      		sum(nvl(a.OPERATE_AREA,0)) OPERATE_AREA,									 ");
		peosql.append("             sum(nvl(a.PRODUCT_AREA,0)) PRODUCT_AREA,									 ");
		peosql.append("             sum(nvl(a.RECOVERY_AREA,0)) RECOVERY_AREA,									 ");
		peosql.append("             sum(nvl(a.RECEPTION_AREA,0)) RECEPTION_AREA,									 ");
		peosql.append("             sum(nvl(a.TRAIN_AREA,0)) TRAIN_AREA,									 ");
		peosql.append("            	sum(nvl(a.TREATMENT_AREA,0)) TREATMENT_AREA,									 ");
		peosql.append("            	sum(nvl(a.WORK_AREA,0)) WORK_AREA,									 ");
		peosql.append("            	sum(nvl(a.LEISURE_AREA,0)) LEISURE_AREA,									 ");
		peosql.append("           	sum(nvl(a.OTHER_AREA,0)) OTHER_AREA									 ");
		
		peosql.append("      from (              ");
		peosql.append("            select t.morg_area, t.fit_id, s.OPERATE_AREA, s.PRODUCT_AREA,  s.RECOVERY_AREA, s.RECEPTION_AREA,                        ");
		peosql.append("                   s.TRAIN_AREA, s.TREATMENT_AREA, s.WORK_AREA, s.LEISURE_AREA, s.OTHER_AREA                                         ");
		peosql.append("            from weal_fit_status t, weal_fit_info s                          ");
		peosql.append("            where t.status = '1'                     					 ");
		peosql.append("            		 and t.task_code = s.task_code(+)                        ");
		peosql.append("           )a                    ");
		peosql.append("       group by rpad(substr(a.morg_area,1,"+indexUp+"),12,'0')         ");
		peosql.append("       )s                       ");               
		peosql.append(" where s.domicile_code(+) = d.id                           ");
		peosql.append("   and d.id = ?         )                                        ");
		typeList.add(Types.VARCHAR);
		argsList.add(domicileCode);
		
		
		peosql.append("   union                                        ");
		
		peosql.append(" (select s.fit_num, s.OPERATE_AREA, s.PRODUCT_AREA, s.RECOVERY_AREA, s.RECEPTION_AREA,             ");
		peosql.append("		  s.TRAIN_AREA,  s.TREATMENT_AREA, s.WORK_AREA, s.LEISURE_AREA,  s.OTHER_AREA, d.id, d.name              ");
		
		peosql.append("from dic_city d, (              ");
		peosql.append("      select rpad(substr(a.morg_area,1,"+index+"),12,'0') domicile_code ,             ");
		peosql.append("      		count(a.fit_id) fit_num,              											 ");
		peosql.append("      		sum(nvl(a.OPERATE_AREA,0)) OPERATE_AREA,									 ");
		peosql.append("             sum(nvl(a.PRODUCT_AREA,0)) PRODUCT_AREA,									 ");
		peosql.append("             sum(nvl(a.RECOVERY_AREA,0)) RECOVERY_AREA,									 ");
		peosql.append("             sum(nvl(a.RECEPTION_AREA,0)) RECEPTION_AREA,									 ");
		peosql.append("             sum(nvl(a.TRAIN_AREA,0)) TRAIN_AREA,									 ");
		peosql.append("            	sum(nvl(a.TREATMENT_AREA,0)) TREATMENT_AREA,									 ");
		peosql.append("            	sum(nvl(a.WORK_AREA,0)) WORK_AREA,									 ");
		peosql.append("            	sum(nvl(a.LEISURE_AREA,0)) LEISURE_AREA,									 ");
		peosql.append("           	sum(nvl(a.OTHER_AREA,0)) OTHER_AREA									 ");
		
		peosql.append("      from (              ");
		peosql.append("            select t.morg_area, t.fit_id, s.OPERATE_AREA, s.PRODUCT_AREA,  s.RECOVERY_AREA, s.RECEPTION_AREA,                        ");
		peosql.append("                   s.TRAIN_AREA, s.TREATMENT_AREA, s.WORK_AREA, s.LEISURE_AREA, s.OTHER_AREA                                         ");
		peosql.append("            from weal_fit_status t, weal_fit_info s                          ");
		peosql.append("            where t.status = '1'                     					 ");
		peosql.append("            		 and t.task_code = s.task_code(+)                        ");
		peosql.append("           )a                    ");
		peosql.append("       group by rpad(substr(a.morg_area,1,"+index+"),12,'0')         ");
		peosql.append("       )s                       ");               
		peosql.append(" where s.domicile_code(+) = d.id                           ");
		peosql.append(" 	and d.id=rpad(substr(d.id, 1, "+index+"), 12, '0')          ");
		if(domicileCode.endsWith("000")){
			peosql.append("   and d.ups = ?      )                                           ");
		}else{
			peosql.append("   and d.id = ?       )                                           ");
		}	
		typeList.add(Types.VARCHAR);
		argsList.add(domicileCode);
		
		peosql.append("   ) b                                           ");
		
		peosql.append("	order by b.id                            ");  

		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			peods = this.executeDataset(peosql.toString(), types, args, true);
		} else {
			peods = this.executeDataset(peosql.toString(), true);
		}
		return peods;
	}
	//建设情况统计
		public DataSet queryCheckinfoReport(ParameterSet pset){
			List<Object> typeList = new ArrayList<Object>();
			List<Object> argsList = new ArrayList<Object>();
			String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
			String startDate=StrUtil.n2b((String)pset.getParameter("startDate"));
			String endDate=StrUtil.n2b((String)pset.getParameter("endDate"));
			int index=12;
			int indexUp=9;
			if(StringUtils.isNotEmpty(domicileCode)){
				if(domicileCode.indexOf("000")<9&&domicileCode.indexOf("000")>0){
					index=getSubstrIndex(domicileCode);
					indexUp=getSubstrIndexInit(domicileCode);
				}
			}
			DataSet peods = new DataSet();
			StringBuffer peosql = new StringBuffer("");
			
			peosql.append("select b.fit_num,b.CHECK_NUM, b.CHECK_PASS_NUM, b.CERT_CHANGE_NUM, b.CANCEL_NUM,  b.id,b.name           ");
			peosql.append("		from (              ");
			
			peosql.append(" (select s.fit_num, s.CHECK_NUM, s.CHECK_PASS_NUM, s.CERT_CHANGE_NUM, s.CANCEL_NUM, d.id, d.name             ");
			
			peosql.append("from dic_city d, (              ");
			peosql.append("      select rpad(substr(a.morg_area,1,"+indexUp+"),12,'0') domicile_code ,             ");
			peosql.append("      		count(distinct(a.fit_id)) fit_num,              											 ");
			peosql.append("      		sum(case when a.apply_type = '2' and (a.apply_stauts='4' or a.apply_stauts='5') then 1 else 0 end) CHECK_NUM,									 ");
			peosql.append("             sum(case when a.apply_type = '2' and a.apply_stauts='4' then 1 else 0 end) CHECK_PASS_NUM,									 ");
			peosql.append("             sum(case when a.apply_type = '3' and a.apply_stauts='4' then 1 else 0 end) CERT_CHANGE_NUM,								 ");
			peosql.append("             sum(case when a.apply_type = '5' and a.apply_stauts='4' then 1 else 0 end) CANCEL_NUM									 ");
			
			peosql.append("      from (              ");
			peosql.append("            select p.morg_area, p.fit_id,p.apply_type,p.apply_stauts                        ");
			peosql.append("            from weal_fit_info s,weal_fit_apply p                         ");
			peosql.append("            where 1=1                     					 ");
			peosql.append("            		 and p.task_code=s.task_code(+)                        ");
			peosql.append("            		 and( (p.data_source='LOCAL' and  substr(p.accept_time,1,10) >= ? ) or (p.data_source='ONLINE' and  substr(p.Submit_Time,1,10) >= ? ) )                        ");
			peosql.append("            		 and( (p.data_source='LOCAL' and  substr(p.accept_time,1,10) <= ? ) or (p.data_source='ONLINE' and  substr(p.Submit_Time,1,10) <= ? ) )                        ");
			
			typeList.add(Types.VARCHAR);
			argsList.add(startDate);
			typeList.add(Types.VARCHAR);
			argsList.add(startDate);
			typeList.add(Types.VARCHAR);
			argsList.add(endDate);
			typeList.add(Types.VARCHAR);
			argsList.add(endDate);
			
			peosql.append("           )a                    ");
			peosql.append("       group by rpad(substr(a.morg_area,1,"+indexUp+"),12,'0')         ");
			peosql.append("       )s                       ");               
			peosql.append(" where s.domicile_code(+) = d.id                           ");
			peosql.append("   and d.id = ?         )                                        ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode);
			
			
			peosql.append("   union                                        ");
			
			peosql.append(" (select s.fit_num, s.CHECK_NUM, s.CHECK_PASS_NUM, s.CERT_CHANGE_NUM, s.CANCEL_NUM, d.id, d.name             ");
			
			peosql.append("from dic_city d, (              ");
			peosql.append("      select rpad(substr(a.morg_area,1,"+index+"),12,'0') domicile_code ,             ");
			peosql.append("      		count(distinct(a.fit_id)) fit_num,              											 ");
			peosql.append("      		sum(case when a.apply_type = '2' and (a.apply_stauts='4' or a.apply_stauts='5') then 1 else 0 end) CHECK_NUM,									 ");
			peosql.append("             sum(case when a.apply_type = '2' and a.apply_stauts='4' then 1 else 0 end) CHECK_PASS_NUM,									 ");
			peosql.append("             sum(case when a.apply_type = '3' and a.apply_stauts='4' then 1 else 0 end) CERT_CHANGE_NUM,								 ");
			peosql.append("             sum(case when a.apply_type = '5' and a.apply_stauts='4' then 1 else 0 end) CANCEL_NUM									 ");
			
			peosql.append("      from (              ");
			peosql.append("            select p.morg_area, p.fit_id,p.apply_type,p.apply_stauts                        ");
			peosql.append("            from weal_fit_info s,weal_fit_apply p                         ");
			peosql.append("            where 1=1                     					 ");
			peosql.append("            		 and p.task_code=s.task_code(+)                        ");
			peosql.append("            		 and( (p.data_source='LOCAL' and  substr(p.accept_time,1,10) >= ? ) or (p.data_source='ONLINE' and  substr(p.Submit_Time,1,10) >= ? ) )                        ");
			peosql.append("            		 and( (p.data_source='LOCAL' and  substr(p.accept_time,1,10) <= ? ) or (p.data_source='ONLINE' and  substr(p.Submit_Time,1,10) <= ? ) )                        ");
			
			typeList.add(Types.VARCHAR);
			argsList.add(startDate);
			typeList.add(Types.VARCHAR);
			argsList.add(startDate);
			typeList.add(Types.VARCHAR);
			argsList.add(endDate);
			typeList.add(Types.VARCHAR);
			argsList.add(endDate);
			
			peosql.append("           )a                    ");
			peosql.append("       group by rpad(substr(a.morg_area,1,"+index+"),12,'0')         ");
			peosql.append("       )s                       ");               
			peosql.append(" where s.domicile_code(+) = d.id                           ");
			peosql.append(" 	and d.id=rpad(substr(d.id, 1, "+index+"), 12, '0')          ");
			if(domicileCode.endsWith("000")){
				peosql.append("   and d.ups = ?      )                                           ");
			}else{
				peosql.append("   and d.id = ?       )                                           ");
			}	
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode);
			
			peosql.append("   ) b                                           ");
			
			peosql.append("	order by b.id                            ");  

			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = (Integer) typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				peods = this.executeDataset(peosql.toString(), types, args, true);
			} else {
				peods = this.executeDataset(peosql.toString(), true);
			}
			peods.addField("PERCENT_PASS");
			for(int i = 0 ;i<peods.getCount();i++){
				Record re = peods.getRecord(i);
				String a = (re.get("CHECK_NUM")!=null?re.get("CHECK_NUM"):"0").toString();
				String b = (re.get("CHECK_PASS_NUM")!=null?re.get("CHECK_PASS_NUM"):"0").toString();
				float Fa=Float.parseFloat(a);
				float Fb=Float.parseFloat(b);
				if(Fa==0){
					float c=0;
					re.set("PERCENT_PASS ",c);
				}else{
					float c=Fb/(Fa)*100;
					BigDecimal m=new BigDecimal(c);
					c=m.setScale(2,BigDecimal.ROUND_HALF_UP).floatValue();
					re.set("PERCENT_PASS",c);
				}
			}
			return peods;
		}
	private int getSubstrIndex(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return 4;
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return 6;
		} else if (areaCode.endsWith("000000")){//县370104000000
			return 9;
		} else if (areaCode.endsWith("000")){//乡370104003000
			return 12;
		}
        return 12;
	}
	private int getSubstrIndexInit(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return 2;
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return 4;
		} else if (areaCode.endsWith("000000")){//县370104000000
			return 6;
		} else if (areaCode.endsWith("000")){//乡370104003000
			return 9;
		}
        return 9;
	}
}
