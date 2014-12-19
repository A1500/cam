package com.inspur.comm.searchhelp.data;

/**
 * 通用帮助字典表databean
 * @author shgtch
 * @date 2011-6-18
 */
public class HelpDic {

	// 编码
	private String value;
	
	// 名称
	private String text;

	/**
	 * 获取 编码
	 * @return
	 */
	public String getValue() {
		return value;
	}

	/**
	 * 设置 编码
	 * @param value
	 */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * 获取 名称
	 * @return
	 */
	public String getText() {
		return text;
	}

	/**
	 * 设置 名称
	 * @param text
	 */
	public void setText(String text) {
		this.text = text;
	}
	
}
