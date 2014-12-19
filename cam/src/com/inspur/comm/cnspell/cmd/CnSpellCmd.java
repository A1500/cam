package com.inspur.comm.cnspell.cmd;

import java.util.List;
import java.util.Map;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.comm.cnspell.dao.ISysCnCharSpellDao;

/**
 * 汉字转拼音cmd
 * @author shgtch
 * @date 2012-9-4
 */
public class CnSpellCmd extends BaseAjaxCommand {
	
	private ISysCnCharSpellDao sysCnCharSpellDao = ScaComponentFactory.getService(ISysCnCharSpellDao.class, "sysCnCharSpellJdbcDao/sysCnCharSpellJdbcDao");

	/**
	 * 根据中文姓名生成拼音姓名码
	 */
	public void getCnStr() {
		String cnStr = (String) getParameter("cnStr");// 中文姓名
		String sType = (String) getParameter("sType");// 传入转换类型
		List list = sysCnCharSpellDao.getCnStrSpell(cnStr, sType);
		setReturn("jsonStr", getCnStrJson(list));
	}
	
	public static String getCnStrJson(List list) {
		StringBuffer cnStrJson = new StringBuffer();
		cnStrJson.append("{\"spell\":[");
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			if (i != 0) {
				cnStrJson.append(",");
			}
			cnStrJson.append("\"");
			cnStrJson.append((String) map.get("SPELL"));
			cnStrJson.append("\"");
		}
		cnStrJson.append("]}");
		return cnStrJson.toString();
	}
	
}
