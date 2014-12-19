package com.inspur.cams.sorg.query.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.query.dao.ISorgSummaryDao;

public class SorgSummaryDao extends EntityDao<SomOrgan> implements ISorgSummaryDao{
	@Override
	@SuppressWarnings("unchecked")
	protected Class getEntityClass() {
		return SomOrgan.class;
	}

	public DataSet querySorgNum(ParameterSet pset) {
		DataSet ds = new DataSet();
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		typeList.add(Types.VARCHAR);
		List<Object> objList = new ArrayList<Object>();
		String summary = (String) pset.getParameter("summary");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		String code = "";
		if(StringUtils.isNotEmpty(morgArea)){
			if(StringUtils.isNotEmpty(summary)&&"yes".endsWith(summary)){
				code=morgArea;
			}else if(morgArea.substring(6).equals("000000")){//街道
				if(morgArea.substring(4).equals("00000000")){//地、市
					if(morgArea.substring(2).equals("0000000000")){//省
						code=morgArea.substring(0,2)+"__00000000";
					}else{
						code=morgArea.substring(0,4)+"__000000";
					}
				}else{
					code=morgArea;
				}
			}else{
				code=morgArea;
			}
		}
		objList.add(code);
		sql.append("select sub.name, ");
        sql.append("sum(decode(sub.sorg_type, 'S', sub.num, 0)) s_num, ");
		sql.append("sum(decode(sub.sorg_type, 'M', sub.num, 0)) m_sum, ");
		sql.append("sum(decode(sub.sorg_type, 'J', sub.num, 0)) j_num, ");
		sql.append("sum(decode(sub.sorg_type, 'S', sub.num, 'M',sub.num,'J',sub.num,0)) total_num ");
		sql.append("from (select t.sorg_type, ");
		sql.append("c.name, ");
		sql.append("decode(t.sorg_type, null, 0, 1) as num, ");
		sql.append("c.id ");
		sql.append("from dic_city c ");
		sql.append("left join (select o.morg_area, o.sorg_type ");
		sql.append("from som_organ o ");
		sql.append("where o.sorg_status = '22' ");
		sql.append("and o.if_branch = '0') t on c.id = t.morg_area ");
		sql.append("where c.id like ? ");
		sql.append(") sub ");
		sql.append("group by sub.name,sub.id ");
		sql.append("order by sub.id ");
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,true);
		}
		return ds;
	}

}
