package com.inspur.cams.comm.syscncharspell.domain.support;

import java.util.List;
import java.util.Map;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.syscncharspell.dao.ISysCnCharSpellDao;
import com.inspur.cams.comm.syscncharspell.domain.ISysCnCharSpellDomain;

 
/**
 * 姓名拼音码
 * @author SAMSUNG
 *
 */
public class SysCnCharSpellDomainImpl implements ISysCnCharSpellDomain {
	@Reference
	private ISysCnCharSpellDao sysCnCharSpellDao;
	
	public String getCnStrSpell(String cnStr, String type) {
		List  list = sysCnCharSpellDao.getCnStrSpell(cnStr,type);
        return  getSysCnStrSpellListJson(list);
	}
	/**
	 * 
	 * @param list
	 * @return
	 */
	public static String getSysCnStrSpellListJson(List list) {
		if (list == null) {
			return null;
		}
		String jsonStr = "";
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			String oneJson = (String) map.get("SPELL");
			if ("".equals(jsonStr)) {
				jsonStr += "\"" + oneJson + "\"";
			} else {
				jsonStr += ",\"" + oneJson + "\"";
			}
		}
		jsonStr = "{\"spell\":[" + jsonStr + "]}";
		return jsonStr;
	}
	 
	/**
	 * 
	 * @return
	 */
	public ISysCnCharSpellDao getSysCnCharSpellDao() {
		return sysCnCharSpellDao;
	}
	/**
	 * 
	 * @param sysCnCharSpellDao
	 */
	public void setSysCnCharSpellDao(ISysCnCharSpellDao sysCnCharSpellDao) {
		this.sysCnCharSpellDao = sysCnCharSpellDao;
	}
}