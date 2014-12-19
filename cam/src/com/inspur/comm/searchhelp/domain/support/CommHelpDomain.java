package com.inspur.comm.searchhelp.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.searchhelp.dao.ICommHelpDao;
import com.inspur.comm.searchhelp.data.CommHelp;
import com.inspur.comm.searchhelp.domain.ICommHelpDomain;


/**
 * 通用帮助domain
 * @author shgtch
 * @date 2011-6-20
 */
public class CommHelpDomain implements ICommHelpDomain {

	// 通用帮助dao
	@Reference
	private ICommHelpDao commHelpDao;
	
	/**
	 * 获取通用帮助配置
	 * @param helpId
	 * @return
	 */
	public CommHelp getCommHelp(String helpId) {
		return commHelpDao.getCommHelp(helpId);
	}
	
	/**
	 * 增加通用帮助配置
	 * @param commHelp
	 */
	public void insertCommHelp(CommHelp commHelp) {
		commHelpDao.insertCommHelp(commHelp);
	}
	
	/**
	 * 更新通用帮助配置
	 * @param commHelp
	 */
	public void updateCommHelp(CommHelp commHelp) {
		commHelpDao.updateCommHelp(commHelp);
	}
	
	/**
	 * 删除通用帮助配置
	 * @param helpId
	 */
	public void deleteCommHelp(String helpId) {
		commHelpDao.deleteCommHelp(helpId);
	}
	
	/**
	 * 查询通用帮助配置
	 * @param ps
	 * @return
	 */
	public DataSet query(ParameterSet ps) {
		return commHelpDao.query(ps);
	}
	
	/**
	 * 获取通用帮助窗口字典集合
	 * @param helpId
	 * @return
	 */
	public DataSet getHelpDataset(ParameterSet ps, String helpId) {
		CommHelp commHelp = getCommHelp(helpId);
		return commHelpDao.getHelpDataset(ps, commHelp);
	}
	
	/**
	 * 获取通用帮助下拉列表字典集合
	 * @param helpId
	 * @return
	 */
	public DataSet getSelectDataset(String helpId) {
		CommHelp commHelp = getCommHelp(helpId);
		return commHelpDao.getSelectDataset(commHelp);
	}
	
	/**
	 * 获取字典解析
	 * @param helpId
	 * @return
	 */
	public String getDicValue(String helpId, String key) {
		CommHelp commHelp = getCommHelp(helpId);
		DataSet ds = commHelpDao.getDicValue(commHelp, key);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < ds.getCount(); i++) {
			Record record = ds.getRecord(i);
			if (i != 0) {
				sb.append(",");
			}
			sb.append(record.get(commHelp.getNameField()));
		}
		return sb.toString();
	}
	
}
