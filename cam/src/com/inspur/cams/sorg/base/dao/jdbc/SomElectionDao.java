package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomElectionDao;
import com.inspur.cams.sorg.base.data.SomElection;

public class SomElectionDao extends EntityDao<SomElection> implements ISomElectionDao{

	@Override
	protected Class<SomElection> getEntityClass() {
		return SomElection.class;
	}
	/**
	 * 换届审批查询用的方法（查询是否办理章程核准、会费备案、负责人备案）
	 * @return
	 */
	public DataSet electionForQuery(ParameterSet pset) {
		List<Integer> typeList=new ArrayList<Integer>();
		List<String> objsList=new ArrayList<String>();
		String applyType =(String) pset.getParameter("applyType");
		String sorgType =(String) pset.getParameter("sorgType");
		String domicileCode =(String) pset.getParameter("domicileCode");
		String sorgName =(String) pset.getParameter("sorgName");
		String sorgCode =(String) pset.getParameter("sorgCode");
		String allChoose =(String) pset.getParameter("allChoose");
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ( ");
		sql.append("  select t.task_code,  m.meeting_id,m.meeting_name,  t.sorg_name,  o.sorg_code,o.sorg_id,o.morg_area,o.BORG_NAME,  m.meeting_date, \n");
		sql.append("    to_char(to_date(m.meeting_date, 'yyyy-mm-dd') + 30, 'yyyy-mm-dd') finishdate, \n");
		sql.append("  (select substr(r.create_time,1,10)  from som_rule r   where r.meeting_id = m.meeting_id ) rule,      \n");
		sql.append("  (select substr(f.create_time,1,10)  from som_fee f    where f.meeting_id = m.meeting_id  ) fee,  \n");
		sql.append("  (select substr(s.create_time,1,10) from som_session s   where s.session_id = m.meeting_id  ) duty  \n");
		sql.append("     from som_apply t, som_election e, som_meeting m ,som_organ o where t.task_code = e.task_code and o.sorg_id=t.sorg_id  \n");
		sql.append("     and e.meeting_id = m.meeting_id  and m.if_old = '0' and t.apply_type = ? and t.if_finish = '1'  \n");
		typeList.add(Types.VARCHAR);
		objsList.add(applyType);
		
		if(StringUtils.isNotEmpty(sorgType)){
			sql.append("    AND t.sorg_type = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
		}
		if(StringUtils.isNotEmpty(sorgType)){
			sql.append("    AND o.morg_area like ? ");
			typeList.add(Types.VARCHAR);
			if(domicileCode.indexOf("000")!=-1){
				objsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
			}else {
				objsList.add(domicileCode+"%");
			}
		}
		if(StringUtils.isNotEmpty(sorgName)){
			sql.append("    AND o.cn_name = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgName);
		}
		if(StringUtils.isNotEmpty(sorgCode)){
			sql.append("    AND o.sorg_code = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgCode);
		}
		sql.append(" ) y ");
		
//		if(StringUtils.isNotEmpty(allChoose)){
//			SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");
//			Date beginDate = new Date();
//			Calendar date = Calendar.getInstance();
//			date.setTime(beginDate);
//			date.set(Calendar.DATE, date.get(Calendar.DATE) - 30);
//			String curDate = dft.format(date.getTime());
//			if("J".equals(sorgType) ){
//				if("0".endsWith(allChoose)){
//					sql.append(" where (y.rule='1' and y.duty='1') or y.meeting_date > ? or y.meeting_date is null");
//				}else{
//					sql.append("  where y.meeting_date < ? and (y.rule='0' or  y.duty='0') ");
//				}
//			}else{
//				if("0".endsWith(allChoose)){
//					sql.append(" where (y.rule='1' and y.duty='1' and y.fee='1') or y.meeting_date > ? or y.meeting_date is null");
//				}else{
//					sql.append("  where y.meeting_date < ? and (y.rule='0' or  y.duty='0' or y.fee = '0') ");
//				}
//			}
//			typeList.add(Types.VARCHAR);
//			objsList.add(curDate);
//		}
		sql.append("    order by y.meeting_date desc");
		
		int[] types = new int[typeList.size()];
		for(int i=0;i<typeList.size();i++){
			types[i] = (Integer)typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		
		return executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
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
