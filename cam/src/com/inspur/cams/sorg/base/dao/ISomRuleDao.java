package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.sorg.base.data.SomRule;

/**
 * 社会组织章程dao接口
 * 
 * @author zhangjian
 * @date 2011-9-19
 */
public interface ISomRuleDao extends BaseCURD<SomRule> {
	public void save(List<SomRule> list);
	public void del(String taskCode);

}
