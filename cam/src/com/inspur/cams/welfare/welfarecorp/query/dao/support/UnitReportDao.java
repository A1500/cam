package com.inspur.cams.welfare.welfarecorp.query.dao.support;

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

import com.inspur.cams.welfare.base.data.WealUnitStatus;
import com.inspur.cams.welfare.welfarecorp.query.dao.IUnitReportDao;
/**
 * @title:福利企业情况统计
 * @description:
 * @author: sunlei
 * @since:2013-12-26
 * @version:1.0
*/
@SuppressWarnings("unchecked")
public class UnitReportDao extends EntityDao<WealUnitStatus> implements IUnitReportDao {
	@Override
	protected Class<WealUnitStatus> getEntityClass() {
		return WealUnitStatus.class;
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
		
		peosql.append("select b.unit_num,b.ECONOMIC_ONE,b.ECONOMIC_TWO,b.ECONOMIC_THREE,b.ECONOMIC_FOUR,b.ECONOMIC_FIVE,             ");
		peosql.append("		  b.ECONOMIC_SIX,b.workers_all,b.workers_deform,b.reg_fund,b.id,b.name              ");
		peosql.append("		from (              ");
		if(indexUp==2){//省级
			peosql.append(" (select s.unit_num,s.ECONOMIC_ONE,s.ECONOMIC_TWO,s.ECONOMIC_THREE,s.ECONOMIC_FOUR,s.ECONOMIC_FIVE,             ");
			peosql.append("		  s.ECONOMIC_SIX,s.workers_all,s.workers_deform,s.reg_fund,d.id,d.name              ");
			
			peosql.append("from dic_city d, (              ");
			peosql.append("      select rpad(substr(a.morg_area,1,"+indexUp+"),12,'0') domicile_code ,             ");
			peosql.append("      count(a.unit_id) unit_num,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='01' then  1  else   0  end) ECONOMIC_ONE,             ");
			peosql.append("      sum(case  when  a.economic_nature_code='02' then  1  else   0  end) ECONOMIC_TWO,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='03' then  1  else   0  end) ECONOMIC_THREE,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='04' then  1  else   0  end) ECONOMIC_FOUR,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='05' then  1  else   0  end) ECONOMIC_FIVE,             ");
			peosql.append("      sum(case  when  a.economic_nature_code<>'05' and a.economic_nature_code<>'04'               ");
			peosql.append("      	and a.economic_nature_code<>'03' and a.economic_nature_code<>'02'             ");
			peosql.append("      	and a.economic_nature_code<>'01' then  1  else   0  end) ECONOMIC_SIX,             ");
			peosql.append("      sum(a.workers_all) workers_all,              ");
			peosql.append("      sum(a.workers_deform) workers_deform,              ");
			peosql.append("      sum(a.reg_fund) reg_fund              ");
			
			peosql.append("      from (              ");
			peosql.append("            select t.morg_area,t.unit_id,t.economic_nature_code,t.reg_fund,s.workers_all,s.workers_deform                       ");
			peosql.append("            from weal_unit_status t, weal_unit_info s                         ");
			peosql.append("            where t.status = '1'                     					 ");
			peosql.append("            		 and t.task_code = s.task_code(+)                        ");
			peosql.append("           )a                    ");
			peosql.append("       group by rpad(substr(a.morg_area,1,"+indexUp+"),12,'0')         ");
			peosql.append("       )s                       ");               
			peosql.append(" where s.domicile_code(+) = d.id                           ");
			peosql.append("   and d.id = ?         )                                        ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode);
		}else{//非省级
		
			peosql.append(" (select s.unit_num,s.ECONOMIC_ONE,s.ECONOMIC_TWO,s.ECONOMIC_THREE,s.ECONOMIC_FOUR,s.ECONOMIC_FIVE,             ");
			peosql.append("		  s.ECONOMIC_SIX,s.workers_all,s.workers_deform,s.reg_fund,d.id,d.name              ");
			
			peosql.append("from dic_city d, (              ");
			peosql.append("      select a.morg_area domicile_code ,             ");
			peosql.append("      count(a.unit_id) unit_num,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='01' then  1  else   0  end) ECONOMIC_ONE,             ");
			peosql.append("      sum(case  when  a.economic_nature_code='02' then  1  else   0  end) ECONOMIC_TWO,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='03' then  1  else   0  end) ECONOMIC_THREE,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='04' then  1  else   0  end) ECONOMIC_FOUR,              ");
			peosql.append("      sum(case  when  a.economic_nature_code='05' then  1  else   0  end) ECONOMIC_FIVE,             ");
			peosql.append("      sum(case  when  a.economic_nature_code<>'05' and a.economic_nature_code<>'04'               ");
			peosql.append("      	and a.economic_nature_code<>'03' and a.economic_nature_code<>'02'             ");
			peosql.append("      	and a.economic_nature_code<>'01' then  1  else   0  end) ECONOMIC_SIX,             ");
			peosql.append("      sum(a.workers_all) workers_all,              ");
			peosql.append("      sum(a.workers_deform) workers_deform,              ");
			peosql.append("      sum(a.reg_fund) reg_fund              ");
			
			peosql.append("      from (              ");
			peosql.append("            select t.morg_area,t.unit_id,t.economic_nature_code,t.reg_fund,s.workers_all,s.workers_deform                       ");
			peosql.append("            from weal_unit_status t, weal_unit_info s                         ");
			peosql.append("            where t.status = '1'                     					 ");
			peosql.append("            		 and t.task_code = s.task_code(+)                        ");
			peosql.append("           )a                    ");
			peosql.append("       group by a.morg_area         ");
			peosql.append("       )s                       ");               
			peosql.append(" where s.domicile_code(+) = d.id                           ");
			peosql.append("   and d.id = ?         )                                        ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode);
		}
		
		peosql.append("   union                                        ");
		
		peosql.append(" (select s.unit_num,s.ECONOMIC_ONE,s.ECONOMIC_TWO,s.ECONOMIC_THREE,s.ECONOMIC_FOUR,s.ECONOMIC_FIVE,             ");
		peosql.append("		  s.ECONOMIC_SIX,s.workers_all,s.workers_deform,s.reg_fund,d.id,d.name              ");
		
		peosql.append("from dic_city d, (              ");
		peosql.append("      select rpad(substr(a.morg_area,1,"+index+"),12,'0') domicile_code ,             ");
		peosql.append("      count(a.unit_id) unit_num,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='01' then  1  else   0  end) ECONOMIC_ONE,             ");
		peosql.append("      sum(case  when  a.economic_nature_code='02' then  1  else   0  end) ECONOMIC_TWO,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='03' then  1  else   0  end) ECONOMIC_THREE,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='04' then  1  else   0  end) ECONOMIC_FOUR,              ");
		peosql.append("      sum(case  when  a.economic_nature_code='05' then  1  else   0  end) ECONOMIC_FIVE,             ");
		peosql.append("      sum(case  when  a.economic_nature_code<>'05' and a.economic_nature_code<>'04'               ");
		peosql.append("      	and a.economic_nature_code<>'03' and a.economic_nature_code<>'02'             ");
		peosql.append("      	and a.economic_nature_code<>'01' then  1  else   0  end) ECONOMIC_SIX,             ");
		peosql.append("      sum(a.workers_all) workers_all,              ");
		peosql.append("      sum(a.workers_deform) workers_deform,              ");
		peosql.append("      sum(a.reg_fund) reg_fund              ");
		
		peosql.append("      from (              ");
		peosql.append("            select t.morg_area,t.unit_id,t.economic_nature_code,t.reg_fund,s.workers_all,s.workers_deform                       ");
		peosql.append("            from weal_unit_status t, weal_unit_info s                         ");
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
