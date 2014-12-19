package com.inspur.comm.cqm.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmViewRelDao;
import com.inspur.comm.cqm.base.data.CqmViewRel;
import com.inspur.comm.cqm.base.domain.ICqmViewRelDomain;
import com.inspur.comm.util.IdHelp;

/**
 * 自定义统计报表模型视图关系domain
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmViewRelDomain implements ICqmViewRelDomain {

	@Reference
	private ICqmViewRelDao cqmViewRelDao;

	/**
	 * 查询 自定义统计报表模型视图关系
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmViewRelDao.query(pset);
	}

	/**
	 * 保存模型视图关系
	 * @param list
	 */
	public void save(List<CqmViewRel> list) {
		for (int i = 0; i < list.size(); i++) {
			CqmViewRel cqmViewRel = (CqmViewRel) list.get(i);
			if (cqmViewRel.getState() == Record.STATE_NEW) {
				insert(cqmViewRel);
			} else if (cqmViewRel.getState() == Record.STATE_MODIFIED) {
				update(cqmViewRel);
			} else if (cqmViewRel.getState() == Record.STATE_DELETED) {
				delete(cqmViewRel.getRelId());
			}
		}
	}
	
	/**
	 * 增加 自定义统计报表模型视图关系
	 * @param cqmViewRel
	 */
	public void insert(CqmViewRel cqmViewRel) {
		cqmViewRel.setRelId(IdHelp.getUUID32());
		cqmViewRelDao.insert(cqmViewRel);
	}
	
	/**
	 * 修改 自定义统计报表模型视图关系
	 * @param cqmViewRel
	 */
	public void update(CqmViewRel cqmViewRel) {
		cqmViewRelDao.update(cqmViewRel);
	}
	
	/**
	 * 删除 自定义统计报表模型视图关系
	 * @param relId
	 */
	public void delete(String relId) {
		cqmViewRelDao.delete(relId);
	}

}