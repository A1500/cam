package com.inspur.cams.sorg.util;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

/**
 * 首页登录代办任务列表弹窗
 * @author Muqi
 * @date 2012-6-18
 */
public class SomLoginHeadMsg extends BaseJdbcDao{
	public SomLoginHeadMsg() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
	}

	public List<Map<String,Object>> getDaiBanList(String organId) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		StringBuffer sql = new StringBuffer();
		if(StringUtils.isNotEmpty(organId)){
			sql.append("SELECT b.type_name, a.act_def_name,count (a.act_def_name) as count"
					  +" FROM wf_dai_ban_task a, wf_process_type b"
					  +" WHERE a.organ_id = ?"
					  +" AND a.process_type = b.type_id"
					  +" AND b.type_id like 'som%'"
					  +" group by b.type_name, a.act_def_name"
					  +" order by b.type_name desc");
			list = this.executeQuery(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{organId});
		}
		return list;
	}

}
